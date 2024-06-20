open Fuzz
open Util
module F = Format
module L = Logger
module SeedPool = Seedcorpus.Seedpool
module CD = Coverage.Domain

let llctx = ALlvm.create_context ()

let initialize () =
  ALlvm.set_opaque_pointers llctx true;
  Config.initialize llctx ();
  Random.self_init ()

let llfuzz (module SP : SeedPool.SEED_POOL) () =
  let open Oracle in
  match !Config.direct with
  | None -> ()
  | Some path ->
      let target_path = CD.Path.parse path |> Option.get in
      let llset = ALlvm.LLModuleSet.create 4096 in

      let module FZ = Fuzzer.Make (SP) in
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

let _ =
  initialize ();
  match (!Config.metric, !Config.queue) with
  | Config.Min_metric, Config.Fifo_queue ->
      let module SP = SeedPool.FifoSeedPool (SeedPool.Seed (CD.MinDistance)) in
      llfuzz (module SP) ()
  | Config.Min_metric, Config.Priority_queue ->
      let module SP =
        SeedPool.PrioritySeedPool (SeedPool.PrioritySeed (CD.MinDistance)) in
      llfuzz (module SP) ()
  | Config.Avg_metric, Config.Fifo_queue ->
      let module SP = SeedPool.FifoSeedPool (SeedPool.Seed (CD.AverageDistance)) in
      llfuzz (module SP) ()
  | Config.Avg_metric, Config.Priority_queue ->
      let module SP =
        SeedPool.PrioritySeedPool (SeedPool.PrioritySeed (CD.AverageDistance)) in
      llfuzz (module SP) ()
