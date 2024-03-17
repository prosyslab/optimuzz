open Fuzz
open Util
module F = Format
module L = Logger
module SeedPool = Seedcorpus.Seedpool
module CD = Coverage.Domain

let llctx = ALlvm.create_context ()

let initialize () =
  Config.initialize llctx ();
  Random.self_init ()

let llfuzz_avg_dist llset () =
  let module Cov = Coverage.Avg_dist in
  let seed_pool = SeedPool.make (module Cov) llctx in
  F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);
  L.info "initial seeds: %d" (SeedPool.cardinal seed_pool);

  seed_pool
  |> SeedPool.iter (fun seed ->
         let filename = SeedPool.name_seed seed in
         F.eprintf "%s@." filename;
         ALlvm.save_ll !Config.corpus_dir filename seed.llm |> ignore);

  if SeedPool.cardinal seed_pool = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  seed_pool
  |> SeedPool.iter (fun seed -> ALlvm.LLModuleSet.add llset seed.llm ());

  if !Config.dry_run then exit 0;

  AUtil.start_time := AUtil.now ();
  L.info "fuzzing campaign starts@.";
  let coverage =
    Fuzzer.run (module Cov) seed_pool llctx llset Fuzzer.Progress.empty
  in
  let end_time = AUtil.now () in
  L.info "fuzzing campaign ends@.";
  L.info "total coverage: %d lines" (CD.Cov.cardinal coverage);
  L.info "time spent: %ds" (end_time - !AUtil.start_time);

  F.printf "\ntotal coverage: %d lines@." (CD.Cov.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !AUtil.start_time)

let llfuzz_min_dist llset () =
  let module Cov = Coverage.Min_dist in
  let seed_pool = SeedPool.make (module Cov) llctx in
  F.printf "#initial seeds: %d@." (SeedPool.cardinal seed_pool);
  L.info "initial seeds: %d" (SeedPool.cardinal seed_pool);

  seed_pool
  |> SeedPool.iter (fun seed ->
         let filename = SeedPool.name_seed seed in
         F.eprintf "%s@." filename;
         ALlvm.save_ll !Config.corpus_dir filename seed.llm |> ignore);

  if SeedPool.cardinal seed_pool = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  seed_pool
  |> SeedPool.iter (fun seed -> ALlvm.LLModuleSet.add llset seed.llm ());

  if !Config.dry_run then exit 0;

  AUtil.start_time := AUtil.now ();
  L.info "fuzzing campaign starts@.";
  let coverage =
    Fuzzer.run (module Cov) seed_pool llctx llset Fuzzer.Progress.empty
  in
  let end_time = AUtil.now () in
  L.info "fuzzing campaign ends@.";
  L.info "total coverage: %d lines" (CD.Cov.cardinal coverage);
  L.info "time spent: %ds" (end_time - !AUtil.start_time);

  F.printf "\ntotal coverage: %d lines@." (CD.Cov.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !AUtil.start_time)

let llfuzz () =
  ALlvm.set_opaque_pointers llctx true;
  initialize ();

  let llset = ALlvm.LLModuleSet.create 4096 in

  match !Config.metric with
  | "avg" -> llfuzz_avg_dist llset ()
  | "min" -> llfuzz_min_dist llset ()
  | _ -> failwith "unknown metric"

let _ = llfuzz ()
