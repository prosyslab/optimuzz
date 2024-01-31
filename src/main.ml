open Fuzz
open Util
module F = Format
module SeedPool = Seedcorpus.Seedpool
module CD = Coverage.Domain

let llctx = ALlvm.create_context ()

let initialize () =
  Config.initialize llctx ();

  (* make directories first *)
  (try Sys.mkdir !Config.out_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.crash_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.corpus_dir 0o755 with _ -> ());

  Random.init !Config.random_seed;

  ()

let main () =
  Printexc.record_backtrace true;
  ALlvm.set_opaque_pointers llctx true;
  initialize ();

  let llset = ALlvm.LLModuleSet.create 4096 in

  (* pattern *)
  if !Config.pattern_path <> "" then (
    let name, pat = !Config.pattern_path |> Pattern.Parser.run in
    let all_instances = Pattern.Instantiation.run name pat in
    List.iter
      (fun llm ->
        match ALlvm.LLModuleSet.get_new_name llset llm with
        | None -> ()
        | Some filename -> ALlvm.save_ll !Config.out_dir filename llm)
      all_instances;
    exit 0);

  (* measure coverage *)
  if !Config.cov_tgt_path <> "" then (
    let res =
      Oracle.Optimizer.run
        ~passes:[ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ]
        !Config.cov_tgt_path
    in
    (match res with
    | Oracle.Optimizer.VALID cov ->
        F.printf "Total coverage: %d@." (CD.Coverage.cardinal cov)
    | _ -> ());
    exit 0);

  (* fuzzing *)
  let seed_pool = SeedPool.make llctx llset in
  F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);

  if !Config.dry_run then exit 0;

  AUtil.start_time := AUtil.now ();
  let coverage = Fuzzer.run seed_pool llctx llset CD.Coverage.empty 0 in
  let end_time = AUtil.now () in

  if not !Config.no_tv then Unix.unlink AUtil.alive2_log;

  F.printf "\ntotal coverage: %d lines@." (CD.Coverage.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !AUtil.start_time)

let _ = main ()
