open Util
module F = Format
module L = Logger
module SP = Seedcorpus.Seedpool
module SD = Seedcorpus.Domain
module CD = Coverage.Domain

let llctx = ALlvm.create_context ()

let initialize () =
  ALlvm.set_opaque_pointers llctx true;
  Config.initialize llctx ();
  Random.self_init ()

let llfuzz_ast_distanced_based (module SP : Seedcorpus.Ast_distance_based.POOL)
    target_path =
  let open Oracle in
  let llset = ALlvm.LLModuleSet.create 4096 in

  let module FZ = Fuzz.Ast_distance_based.Make (SP) in
  let module Coverage = CD.AstCoverage in
  let module Progress = CD.Progress (Coverage) in
  (* fuzzing *)
  let seed_pool = SP.make llctx target_path in
  F.printf "#initial seeds: %d@." (SP.length seed_pool);
  L.info "initial seeds: %d" (SP.length seed_pool);

  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name seed in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  if SP.length seed_pool = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  seed_pool
  |> SP.iter (fun (seed : SP.Seed.t) ->
         ALlvm.LLModuleSet.add llset (SP.Seed.llmodule seed) ());

  if !Config.dry_run then exit 0;

  AUtil.start_time := AUtil.now ();
  L.info "fuzzing campaign starts@.";
  let coverage = FZ.run target_path seed_pool llctx llset Progress.empty in
  let end_time = AUtil.now () in
  L.info "fuzzing campaign ends@.";
  L.info "total coverage: %d lines" (Coverage.cardinal coverage);
  L.info "time spent: %ds" (end_time - !AUtil.start_time);

  F.printf "\ntotal coverage: %d lines@." (Coverage.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !AUtil.start_time)

let llfuzz_edge_cov_based () =
  let open Oracle in
  let module SP = Seedcorpus.Edge_cov_based in
  let module FZ = Fuzz.Edge_cov_based in
  let module Progress = CD.Progress (CD.EdgeCoverage) in
  let llset = ALlvm.LLModuleSet.create 4096 in
  let seed_pool, init_cov = SP.make llctx in
  F.printf "#initial seeds: %d@." (SP.length seed_pool);
  L.info "initial seeds: %d" (SP.length seed_pool);

  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name seed in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  if SP.length seed_pool = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  seed_pool
  |> SP.iter (fun (seed : SP.Seed.t) ->
         ALlvm.LLModuleSet.add llset (SP.Seed.llmodule seed) ());

  if !Config.dry_run then exit 0;

  let progress = ref Progress.empty in
  progress := Progress.add_cov init_cov !progress;
  seed_pool |> SP.iter (fun _ -> progress := Progress.inc_gen !progress);

  let _coverage = FZ.run seed_pool llctx llset !progress in
  L.info "fuzzing campaign ends@."

let _ =
  initialize ();
  match !Config.mode with
  (* | Directed (file, lineno) -> (
      F.printf "direct mode@.";
      let target_path = CD.Path.parse s |> Option.get in
      match (!Config.metric, !Config.queue) with
      | Config.Min_metric, Config.Fifo_queue ->
          let module MinFifoPool =
            SP.FifoSeedPool (SD.DistancedSeed (CD.MinDistance)) in
          llfuzz (module MinFifoPool) target_path
      | Config.Min_metric, Config.Priority_queue ->
          let module MinPriorityPool =
            SP.PrioritySeedPool (SD.PriorityDistancedSeed (CD.MinDistance)) in
          llfuzz (module MinPriorityPool) target_path
      | Config.Avg_metric, Config.Fifo_queue ->
          let module AvgFifoPool =
            SP.FifoSeedPool (SD.DistancedSeed (CD.AverageDistance)) in
          llfuzz (module AvgFifoPool) target_path
      | Config.Avg_metric, Config.Priority_queue ->
          let module AvgPriorityPool =
            SP.PrioritySeedPool (SD.PriorityDistancedSeed (CD.AverageDistance)) in
          llfuzz (module AvgPriorityPool) target_path) *)
  | Greybox ->
      F.printf "greybox mode@.";
      llfuzz_edge_cov_based ()
  | Blackbox ->
      F.printf "blackbox mode@.";
      failwith "Not implemented"
  | _ -> failwith "Not implemented"
