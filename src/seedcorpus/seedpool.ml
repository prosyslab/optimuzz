open Util
module CD = Coverage.Domain
module L = Logger
module D = Domain

let run_opt llm =
  let h = ALlvm.hash_llm llm in
  let filename = Format.sprintf "id:%010d.ll" h in
  let filename = ALlvm.save_ll !Config.out_dir filename llm in
  let module Opt = Oracle.Optimizer in
  let res = Opt.run ~passes:!Config.optimizer_passes filename in
  AUtil.clean filename;
  match res with
  | Error Opt.File_not_found ->
      Format.eprintf "Coverage not generated: %s@." filename;
      None
  | Error _ -> None
  | Ok lines -> Some (h, lines)

let can_optimize file =
  let module Opt = Oracle.Optimizer in
  match Opt.run ~passes:!Config.optimizer_passes file with
  | Error Non_zero_exit | Error Hang ->
      L.info "%s cannot be optimized" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      false
  | Ok _ | Error File_not_found ->
      L.info "%s can be optimized" file;
      AUtil.name_opted_ver file |> AUtil.clean;
      true

let collect_cleaned_seeds llctx seed_dir =
  assert (Sys.file_exists seed_dir && Sys.is_directory seed_dir);

  let seed_files = Sys.readdir seed_dir |> Array.to_list in

  let optimizable_seeds =
    seed_files
    |> List.map (Filename.concat seed_dir)
    |> List.filter can_optimize
    |> List.filter_map (fun path ->
           match ALlvm.read_ll llctx path with
           | Error _ -> None
           | Ok llm -> Some (path, llm))
  in
  if optimizable_seeds = [] then (
    L.info "No optimizable seeds found.";
    exit 1);

  let cleaned_seeds =
    optimizable_seeds
    |> List.filter (fun (_path, llm) -> Prep.check_llm_for_mutation llm)
    (* |> List.filter_map (fun (path, llm) ->
           ALlvm.clean_module_data llm;
           Prep.clean_llm llctx true llm |> Option.map (fun llm -> (path, llm))) *)
  in

  (* cleaned_seeds can be cached since the collection is independent of target_path *)
  if cleaned_seeds = [] then (
    L.info "No cleaned seeds found.";
    exit 1);

  cleaned_seeds

let parse_seed_filename filename =
  let filename = Filename.chop_extension filename in
  (* covers:true -> true *)
  let parse_covers s =
    let colon = String.index s ':' in
    String.sub s (colon + 1) (String.length s - colon - 1)
  in

  (* score:4.500 -> 4.500 *)
  let parse_score s =
    let colon = String.index s ':' in
    String.sub s (colon + 1) (String.length s - colon - 1)
  in
  match String.split_on_char ',' filename with
  | [ _date; _id; score; covers ] ->
      let covers = parse_covers covers in
      let score = parse_score score in
      Ok (covers, score)
  | [ _date; _id; _src; score; covers ] ->
      let covers = parse_covers covers in
      let score = parse_score score in
      Ok (covers, score)
  | lst ->
      List.iter (Format.eprintf "%s@.") lst;
      Format.asprintf "Can't parse the filename: %s@." filename |> Result.error
