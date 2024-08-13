(**
  The initializer outputs four different files
   1. pcguards.cov: guard identifiers
   2. controlflow.cov: pc and its successors and called functions
   3. instrumentedblocks.cov: PCs of instrumented blocks
   4. targetblocks.cov: (filename, linenumber, pc)

  
  When the program runs, [cov.cov] is generated, which contains (pc, guard) pairs.
*)

open Util

module InstrumentedBlocks = struct
  include Map.Make (Int)

  let filename = "instrumentedblocks.cov"

  let parse_line line =
    match String.split_on_char ',' line with
    | [ pc; is_entry ] -> (int_of_string pc, is_entry = "1")
    | _ -> failwith "Malformed line detected"

  let read filename =
    AUtil.read_lines filename |> List.map parse_line |> List.to_seq |> of_seq
end

module PCGuards = struct
  include Set.Make (Int64)

  let filename = "pcguards.cov"

  (* NOTE: [int_of_string] parses an hex-string if the string begins with "0x" *)
  let read filename =
    AUtil.read_lines filename |> List.map Int64.of_string |> of_list
end

(*
  Example Input

  0x5618ee1e8330,,0x5618ee1e83c0:
  0x5618ee1e83c0,0x5618ee1e846b:0x5618ee1e8488:,0x5618ee201bb0:
  0x5618ee1e846b,0x5618ee1e8a74:,
  0x5618ee1e8488,0x5618ee1e849e:0x5618ee1e84bb:,0x5618ee1f6f40:
  0x5618ee1e849e,0x5618ee1e8a74:,
  0x5618ee1e84bb,0x5618ee1e84d5:0x5618ee1e84f2:,0x5618ee1f6eb0:
*)
module ControlFlow = struct
  include Map.Make (Int)

  type elt = { succs : int list; preds : int list }
  (** pc -> successor-pc list *)

  let filename = "controlflow.cov"
  let make_node succs preds = { succs; preds }

  let parse_section section =
    String.split_on_char ':' section
    |> List.filter_map (fun x ->
           if x = "" then None else Some (int_of_string x))

  let parse_line line =
    match String.split_on_char ',' line with
    | [ pc; succs; _called ] ->
        (int_of_string pc, { succs = parse_section succs; preds = [] })
    | _ -> failwith "Malformed line detected"

  (** fill predecessor edges in the cfg. should be called only once after reading the cfg *)
  let compute_preds cfg =
    fold
      (fun pc { succs; _ } acc ->
        List.fold_left
          (fun acc succ ->
            update succ
              (function
                | Some { succs; preds } -> Some { succs; preds = pc :: preds }
                | None -> None (* this shouldn't happen *))
              acc)
          acc succs)
      cfg cfg

  let read filename =
    let succs_map =
      AUtil.read_lines filename |> List.map parse_line |> List.to_seq |> of_seq
    in
    compute_preds succs_map
end

module TargetBlocks = struct
  include Map.Make (struct
    type t = string * int

    let compare = compare
  end)

  let filename = "targetblocks.cov"

  (* /home/llfuzz/llfuzz-experiment/cases/builds/62401/llvm/lib/Analysis/InstructionSimplify.cpp:706,0x5618ee1e8330 *)
  let parse_line line =
    match String.split_on_char ',' line with
    | [ file_and_lineno; pc ] -> (
        match String.split_on_char ':' file_and_lineno with
        | [ file; lineno ] -> ((file, int_of_string lineno), int_of_string pc)
        | _ -> failwith "Malformed line detected")
    | _ -> failwith "Malformed line detected"

  let read filename =
    AUtil.read_lines filename |> List.map parse_line |> List.to_seq |> of_seq
end

module CoverageFile = struct
  let filename = "cov.cov"

  let read filename =
    AUtil.read_lines filename
    |> List.map (fun line ->
           match String.split_on_char ',' line with
           | [ pc; guard ] -> (int_of_string pc, int_of_string guard)
           | _ -> failwith "Malformed line detected")
    |> List.to_seq
end

module TB = TargetBlocks
module PCG = PCGuards
module CF = ControlFlow
module IB = InstrumentedBlocks

type pc = int
type cfg = CF.elt CF.t

(* trace back from the target_pc, slicing off unreachable edges on its way to the entry block *)
let slice_cfg (cfg : cfg) (target_pc : pc) =
  let module Visited = Set.Make (Int) in
  let rec backward_slice queue visited sliced_cfg =
    match queue with
    | [] -> sliced_cfg
    | current_pc :: rest -> (
        if Visited.mem current_pc visited then
          backward_slice rest visited sliced_cfg
        else
          let visited' = Visited.add current_pc visited in
          match CF.find_opt current_pc cfg with
          | None -> backward_slice rest visited' sliced_cfg
          | Some { succs; preds } ->
              let filtered_succs =
                List.filter (fun s -> Visited.mem s visited') succs
              in
              let sliced_cfg' =
                CF.add current_pc (CF.make_node filtered_succs preds) sliced_cfg
              in
              backward_slice (preds @ rest) visited' sliced_cfg')
  in
  backward_slice [ target_pc ] Visited.empty CF.empty
