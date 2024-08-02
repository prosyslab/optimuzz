open Fuzz
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

let llfuzz (module SP : SD.SEED_POOL) target_path =
  let open Oracle in
  let llset = ALlvm.LLModuleSet.create 4096 in

  let module FZ = Fuzzer.Make_directed (SP) in
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
  let coverage =
    FZ.run target_path seed_pool llctx llset Fuzzer.Progress.empty
  in
  let end_time = AUtil.now () in
  L.info "fuzzing campaign ends@.";
  L.info "total coverage: %d lines" (CD.Coverage.cardinal coverage);
  L.info "time spent: %ds" (end_time - !AUtil.start_time);

  F.printf "\ntotal coverage: %d lines@." (CD.Coverage.cardinal coverage);
  F.printf "time spend: %ds@." (end_time - !AUtil.start_time)

let llfuzz_undirected (module SP : SD.UNDIRECTED_SEED_POOL) =
  let open Oracle in
  let llset = ALlvm.LLModuleSet.create 4096 in

  let module FZ = Fuzzer.Make_undirected (SP) in
  let seed_pool = SP.make llctx in
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
  let coverage = FZ.run seed_pool llctx llset Fuzzer.Progress.empty in
  L.info "fuzzing campaign ends@."

let _ =
  initialize ();
  match !Config.direct with
  | Some s -> (
      let module MinFifoPool = SP.FifoSeedPool (SD.Seed (CD.MinDistance)) in
      let module MinPriorityPool =
        SP.PrioritySeedPool (SD.PrioritySeed (CD.MinDistance)) in
      let module AvgFifoPool = SP.FifoSeedPool (SD.Seed (CD.AverageDistance)) in
      let module AvgPriorityPool =
        SP.PrioritySeedPool (SD.PrioritySeed (CD.AverageDistance)) in
      F.printf "direct mode@.";
      let target_path = CD.Path.parse s |> Option.get in

      match (!Config.metric, !Config.queue) with
      | Config.Min_metric, Config.Fifo_queue ->
          llfuzz (module MinFifoPool) target_path
      | Config.Min_metric, Config.Priority_queue ->
          llfuzz (module MinPriorityPool) target_path
      | Config.Avg_metric, Config.Fifo_queue ->
          llfuzz (module AvgFifoPool) target_path
      | Config.Avg_metric, Config.Priority_queue ->
          llfuzz (module AvgPriorityPool) target_path)
  | _ ->
      let module UndirectedPool = SP.UndirectedPool (SD.NaiveSeed) in
      F.printf "undirected mode@.";
      llfuzz_undirected (module UndirectedPool)
