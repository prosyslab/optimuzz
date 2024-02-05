open Util
module CD = Coverage.Domain
module SD = Seedcorpus.Domain
module F = Format
module Fuzzer = Fuzz.Fuzzer

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

let handle_cov_tgt_path (module Cov : CD.COVERAGE) =
  let module Optimizer = Oracle.Optimizer (Cov) in
  if !Config.cov_tgt_path <> "" then (
    let res =
      Optimizer.run
        ~passes:[ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ]
        !Config.cov_tgt_path
    in
    (match res with
    | Optimizer.VALID cov -> F.printf "Total coverage: %d@." (Cov.cardinal cov)
    | _ -> ());
    exit 0)

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

  match !Config.metric with
  | "avg" ->
      let module CovAvg = CD.Make_coverage (CD.DistanceSetAvg) in
      let module SeedPool = SD.NaiveSeedPool (CovAvg) in
      handle_cov_tgt_path (module CovAvg);

      let module Campaign = Fuzz.Fuzzer.Make_campaign (CovAvg) in
      (* fuzzing *)
      let seed_pool = SeedPool.make llctx llset in
      F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);

      if SeedPool.cardinal seed_pool = 0 then (
        F.printf "no seed loaded@.";
        exit 0);

      if !Config.dry_run then exit 0;

      AUtil.start_time := AUtil.now ();
      let coverage =
        Campaign.run seed_pool llctx llset Campaign.Progress.empty
      in
      let end_time = AUtil.now () in

      F.printf "\ntotal coverage: %d lines@."
        (Campaign.SeedPool.Cov.cardinal coverage);
      F.printf "time spend: %ds@." (end_time - !AUtil.start_time)
  | "min" ->
      let module CovMin = CD.Make_coverage (CD.DistanceSetMin) in
      let module SeedPool = SD.NaiveSeedPool (CovMin) in
      handle_cov_tgt_path (module CovMin);

      let module Campaign = Fuzz.Fuzzer.Make_campaign (CovMin) in
      (* fuzzing *)
      let seed_pool = SeedPool.make llctx llset in
      F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);

      if SeedPool.cardinal seed_pool = 0 then (
        F.printf "no seed loaded@.";
        exit 0);

      if !Config.dry_run then exit 0;

      AUtil.start_time := AUtil.now ();
      let coverage =
        Campaign.run seed_pool llctx llset Campaign.Progress.empty
      in
      let end_time = AUtil.now () in

      F.printf "\ntotal coverage: %d lines@."
        (Campaign.SeedPool.Cov.cardinal coverage);
      F.printf "time spend: %ds@." (end_time - !AUtil.start_time)
  | _ -> failwith ""

let _ = main ()
