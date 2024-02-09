open Fuzz
open Util
module F = Format
module SeedPool = Seedcorpus.Seedpool
module CD = Coverage.Domain

let llctx = ALlvm.create_context ()

let initialize () =
  Config.initialize llctx ();

  (* make directories first *)
  (try Sys.mkdir !Config.out_dir 0o755
   with Sys_error msg ->
     F.eprintf "%s@." msg;
     F.eprintf "It seems like the output directory already exists.@.";
     F.eprintf "We don't want to mess up with existing files. Exiting...@.";
     exit 0);
  (try Sys.mkdir !Config.crash_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.corpus_dir 0o755 with _ -> ());

  Random.init !Config.random_seed;
  Config.set_intereseting_types llctx;

  ()

let do_pattern_only llset () =
  let name, pat = !Config.pattern_path |> Pattern.Parser.run in
  let all_instances = Pattern.Instantiation.run name pat in
  List.iter
    (fun llm ->
      match ALlvm.LLModuleSet.get_new_name llset llm with
      | None -> ()
      | Some filename -> ALlvm.save_ll !Config.out_dir filename llm)
    all_instances;
  exit 0

let measure_coverage_only ~passes () =
  let open Oracle in
  let res = Optimizer.run ~passes !Config.cov_tgt_path in
  passes |> List.iter (fun pass -> F.printf "Pass: %s@." pass);
  (match res with
  | Optimizer.VALID cov ->
      F.printf "Total coverage: %d@." (CD.Coverage.cardinal cov)
  | _ -> ());
  exit 0

let main () =
  let open Oracle in
  Printexc.record_backtrace true;
  ALlvm.set_opaque_pointers llctx true;
  initialize ();

  let llset = ALlvm.LLModuleSet.create 4096 in

  (* pattern *)
  if !Config.pattern_path <> "" then do_pattern_only llset ();

  (* measure coverage *)
  if !Config.cov_tgt_path <> "" then
    measure_coverage_only ~passes:[ "instcombine" ] ();

  (* fuzzing *)
  let seed_pool = SeedPool.make llctx llset in
  F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);

  if SeedPool.cardinal seed_pool = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  if !Config.dry_run then exit 0;

  AUtil.start_time := AUtil.now ();
  let coverage = Fuzzer.run seed_pool llctx llset Fuzzer.Progress.empty in
  let end_time = AUtil.now () in

  F.printf "\ntotal coverage: %d lines@." (CD.Coverage.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !AUtil.start_time)

let _ = main ()
