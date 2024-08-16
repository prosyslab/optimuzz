open Util
module F = Format
module L = Logger
module SP = Seedcorpus.Seedpool
module SD = Seedcorpus.Domain
module CD = Coverage.Domain

let llctx = ALlvm.create_context ()

let initialize () =
  Printexc.record_backtrace true;
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

let pp_print_hex_int ppf n = F.fprintf ppf "0x%x" n

let llfuzz_cfg_slicing_based_directed filename lineno =
  (* collect CFG information *)
  let open Oracle in
  let module SP = Seedcorpus.Sliced_cfg_edge_cov_based in
  let module FZ = Fuzz.Sliced_cfg_edge_cov_based in
  let module Progress = CD.Progress (CD.SancovEdgeCoverage) in
  AUtil.cmd [ "rm"; "*.cov" ] |> ignore;
  AUtil.cmd [ !Config.opt_bin; "--help"; ">"; "/dev/null" ] |> ignore;

  (* now the CFG information files are generated *)
  let module CS = Coverage.Sancov in
  (* control flow graph *)
  let cfg = CS.CF.read CS.CF.filename in
  (* target blocks table *)
  let tb = CS.TB.read CS.TB.filename in
  (* guards *)
  let guards = CS.PCG.read CS.PCG.filename in
  (* instrumented blocks *)
  let ib = CS.IB.read CS.IB.filename in

  (* TODO: this can raise Not_found exception *)
  let target_pc = CS.TB.find (filename, lineno) tb in
  F.printf "target_pc: 0x%x@." target_pc;

  let sliced_cfg, distance_map = CS.slice_cfg cfg target_pc in
  let pp_print_hex_int_list = F.pp_print_list pp_print_hex_int in
  F.printf "sliced_cfg: ";
  sliced_cfg
  |> CS.CF.iter (fun pc node ->
         F.printf "pc: 0x%x, succs: [%a], preds: [%a]@." pc
           pp_print_hex_int_list node.CS.CF.succs pp_print_hex_int_list
           node.CS.CF.preds);
  F.printf "distance_map: ";
  distance_map
  |> CS.CF.iter (fun node distance ->
         F.printf "node: 0x%x, distance %d\n" node distance);

  if !Config.dry_run then exit 0;

  let selector = CS.selective_coverage ib sliced_cfg in

  let seed_pool, init_cov = SP.make llctx selector distance_map in
  let sp_size = SP.length seed_pool in

  if sp_size = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  let llset = ALlvm.LLModuleSet.create sp_size in
  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name (SP.Seed.llmodule seed) in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  let progress = ref Progress.empty in
  progress := Progress.add_cov init_cov !progress;
  seed_pool |> SP.iter (fun _ -> progress := Progress.inc_gen !progress);

  let _coverage = FZ.run selector seed_pool distance_map llctx llset in
  L.info "fuzzing campaign ends@."

let llfuzz_edge_cov_based_greybox () =
  let open Oracle in
  let module SP = Seedcorpus.Edge_cov_based in
  let module FZ = Fuzz.Edge_cov_based in
  let module Progress = CD.Progress (CD.EdgeCoverage) in
  let seed_pool, init_cov = SP.make llctx in

  let sp_size = SP.length seed_pool in
  F.printf "#initial seeds: %d@." sp_size;
  L.info "initial seeds: %d" sp_size;

  seed_pool
  |> SP.iter (fun seed ->
         let filename = SP.Seed.name seed in
         ALlvm.save_ll !Config.corpus_dir filename (SP.Seed.llmodule seed)
         |> ignore);

  if sp_size = 0 then (
    F.printf "no seed loaded@.";
    exit 0);

  if !Config.dry_run then exit 0;

  let llset = ALlvm.LLModuleSet.create sp_size in

  seed_pool
  |> SP.iter (fun (seed : SP.Seed.t) ->
         ALlvm.LLModuleSet.add llset (SP.Seed.llmodule seed) ());

  let progress = ref Progress.empty in
  progress := Progress.add_cov init_cov !progress;
  seed_pool |> SP.iter (fun _ -> progress := Progress.inc_gen !progress);

  let _coverage = FZ.run seed_pool llctx llset !progress in
  L.info "fuzzing campaign ends@."

let _ =
  initialize ();
  match !Config.mode with
  | Config.Mode.Ast_distance_based s -> (
      F.printf "ast-distance based directed mode@.";
      let target_path = CD.Path.parse s |> Option.get in
      let module SA = Seedcorpus.Ast_distance_based in
      match (!Config.metric, !Config.queue) with
      | Config.Min_metric, Config.Fifo_queue ->
          let module MinFifoPool =
            SA.FifoSeedPool (SD.DistancedSeed (CD.MinDistance)) in
          llfuzz_ast_distanced_based (module MinFifoPool) target_path
      | Config.Min_metric, Config.Priority_queue ->
          let module MinPriorityPool =
            SA.PrioritySeedPool (SD.PriorityDistancedSeed (CD.MinDistance)) in
          llfuzz_ast_distanced_based (module MinPriorityPool) target_path
      | Config.Avg_metric, Config.Fifo_queue ->
          let module AvgFifoPool =
            SA.FifoSeedPool (SD.DistancedSeed (CD.AverageDistance)) in
          llfuzz_ast_distanced_based (module AvgFifoPool) target_path
      | Config.Avg_metric, Config.Priority_queue ->
          let module AvgPriorityPool =
            SA.PrioritySeedPool (SD.PriorityDistancedSeed (CD.AverageDistance)) in
          llfuzz_ast_distanced_based (module AvgPriorityPool) target_path)
  | Directed (filename, lineno) ->
      F.printf "CFG slicing based directed mode@.";
      llfuzz_cfg_slicing_based_directed filename lineno
  | Greybox ->
      F.printf "greybox mode@.";
      llfuzz_edge_cov_based_greybox ()
  | Blackbox ->
      F.printf "blackbox mode@.";
      failwith "Not implemented"
