(**
  The initializer outputs four different files
   1. pcguards.cov: pairs of pc and guard
   2. controlflow.cov: pc and its successors and called functions
   3. instrumentedblocks.cov: PCs of instrumented blocks
   4. targetblocks.cov: (filename, linenumber, pc)

  
  When the program runs, [cov.cov] is generated, which contains (pc, guard) pairs.
*)

open Util

let collect_guards = failwith "Not implemented" (* pcguards.cov *)
let collect_blocks = failwith "Not implemented"
let collect_cf = failwith "Not implemented"
let collect_target_blocks = failwith "Not implemented"

module PCGuards = struct
  include Set.Make (Int)

  let filename = "pcguards.cov"

  (* NOTE: [int_of_string] parses an hex-string if the string begins with "0x" *)
  let read filename =
    AUtil.read_lines filename |> List.map int_of_string |> of_list
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

  type t = { succs : int list; called : int list }

  let filename = "controlflow.cov"

  let parse_section section =
    String.split_on_char ':' section
    |> List.filter_map (fun x ->
           if x = "" then None else Some (int_of_string x))

  let parse_line line =
    match String.split_on_char ',' line with
    | [ pc; succs; called ] ->
        ( int_of_string pc,
          { succs = parse_section succs; called = parse_section called } )
    | _ -> failwith "Malformed line detected"

  let read filename =
    AUtil.read_lines filename |> List.map parse_line |> List.to_seq |> of_seq
end

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
