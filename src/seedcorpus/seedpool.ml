open Util
module CD = Coverage.Domain
module L = Logger

type seed_t = {
  priority : int;
  llm : Llvm.llmodule;
  covers : bool;
  score : float;
}

type t = seed_t AUtil.PrioQueue.queue

let pp_seed fmt seed =
  Format.fprintf fmt "score: %.3f, covers: %b" seed.score seed.covers

let name_seed ?(parent : seed_t option) (seed : seed_t) =
  let hash = ALlvm.string_of_llmodule seed.llm |> Hashtbl.hash in
  match parent with
  | None ->
      Format.sprintf "id:%010d,score:%f,covers:%b.ll" hash seed.score
        seed.covers
  | Some { llm = src; _ } ->
      Format.sprintf "id:%010d,src:%010d,score:%f,covers:%b.ll" hash
        (ALlvm.string_of_llmodule src |> Hashtbl.hash)
        seed.score seed.covers

let get_prio covers score =
  if covers then 0 else score |> Float.mul 10.0 |> Float.to_int

let push s pool = AUtil.PrioQueue.insert pool s.priority s
let pop pool = AUtil.PrioQueue.extract pool
let cardinal = AUtil.PrioQueue.length
let push_list l (p : t) = List.fold_left (fun pool seed -> push seed pool) p l
let iter = AUtil.PrioQueue.iter

(* If the functions return a constant, copy the functions to return another instruction and delete the original function. *)

(** make seedpool from Config.seed_dir. this queue contains llmodule, covered, distance *)
let make llctx =
  let dir = !Config.seed_dir in
  let target_path = CD.Path.parse !Config.cov_directed |> Option.get in
  assert (Sys.file_exists dir && Sys.is_directory dir);

  let seed_files = Sys.readdir dir |> Array.to_list in

  let can_optimize file =
    let path = Filename.concat dir file in
    match Oracle.Optimizer.run ~passes:[ "instcombine" ] path with
    | CRASH | INVALID ->
        AUtil.name_opted_ver path |> AUtil.clean;
        false
    | VALID _ ->
        AUtil.name_opted_ver path |> AUtil.clean;
        true
  in

  let score_func =
    match !Config.metric with
    | "avg" -> CD.Coverage.avg_score
    | "min" -> CD.Coverage.min_score
    | _ -> failwith "invalid metric"
  in

  (* pool_covers contains seeds which cover the target *)
  (* other_seeds contains seeds which do not *)
  let pool_covers, other_seeds =
    seed_files
    |> List.fold_left
         (fun (pool_first, other_seeds) file ->
           let path = Filename.concat dir file in
           if can_optimize file |> not then (pool_first, other_seeds)
           else
             let llm = ALlvm.read_ll llctx path in
             match llm with
             | Error msg ->
                 Format.eprintf "Error while parsing a seed (%s): %s@." path msg;
                 (pool_first, other_seeds)
             | Ok llm -> (
                 ALlvm.clean_module_data llm;
                 match Prep.clean_llm llctx true llm with
                 | None -> (pool_first, other_seeds)
                 | Some llm -> (
                     let h = ALlvm.hash_llm llm in
                     let filename = Format.sprintf "id:%010d.ll" h in
                     let filename =
                       ALlvm.save_ll !Config.out_dir filename llm
                     in
                     let res =
                       Oracle.Optimizer.run ~passes:[ "instcombine" ] filename
                     in
                     AUtil.clean filename;
                     match res with
                     | CRASH | INVALID -> (pool_first, other_seeds)
                     | VALID cov ->
                         let covers =
                           CD.Coverage.cover_target target_path cov
                         in
                         let score = score_func target_path cov in
                         let score_int =
                           match score with
                           | None -> !Config.max_distance |> float_of_int
                           | Some x -> x
                         in
                         let seed =
                           {
                             priority = get_prio covers score_int;
                             llm;
                             covers;
                             score = score_int;
                           }
                         in
                         L.info "seed: %s, %a" file pp_seed seed;
                         if covers then (seed :: pool_first, other_seeds)
                         else (pool_first, seed :: other_seeds))))
         ([], [])
  in

  let hash llm = ALlvm.string_of_llmodule llm |> Hashtbl.hash in
  (* if we have covering seeds, we use covering seeds only. *)
  if pool_covers = [] then (
    L.info "No covering seeds found. Using closest seeds.";
    (* pool_closest contains seeds which are closest to the target *)
    let _pool_cnt, pool_closest =
      other_seeds
      |> List.sort_uniq (fun a b -> compare (hash a.llm) (hash b.llm))
      |> List.sort (fun a b -> compare a.score b.score)
      |> List.fold_left
           (fun (cnt, pool) seed ->
             if cnt >= !Config.max_initial_seed then (cnt, pool)
             else (cnt + 1, push seed pool))
           (0, AUtil.PrioQueue.empty)
    in
    pool_closest)
  else (
    (* if we have covering seeds, we use covering seeds only. *)
    L.info "Covering seeds found. Using them only.";
    let pool_covers =
      pool_covers
      |> List.sort_uniq (fun a b -> compare (hash a.llm) (hash b.llm))
    in
    push_list pool_covers AUtil.PrioQueue.empty)
