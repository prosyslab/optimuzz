open Util
open Oracle
(* module Oracle = Oracle *)

module SeedTuple = struct
  type t = Llvm.llmodule * int

  let compare (llm1, distance1) (llm2, distance2) =
    if distance1 == distance2 then
      let llm1_size = llm1 |> ALlvm.string_of_llmodule |> String.length in
      let llm2_size = llm2 |> ALlvm.string_of_llmodule |> String.length in
      Int.compare llm1_size llm2_size
    else Int.compare distance1 distance2
end

module SeedSet = struct
  include Set.Make (SeedTuple)

  let add seedtuple set =
    if cardinal set < !Config.max_initial_seed then add seedtuple set
    else
      let filtered =
        filter
          (fun tuple ->
            if SeedTuple.compare tuple seedtuple <= 0 then true else false)
          set
      in
      if cardinal filtered < !Config.max_initial_seed then
        add seedtuple filtered
      else filtered
end

type t = (ALlvm.llmodule * bool) Queue.t

let push s pool =
  Queue.push s pool;
  pool

let pop pool = (Queue.pop pool, pool)
let cardinal = Queue.length

let of_dir dir llctx =
  assert (Sys.file_exists dir && Sys.is_directory dir);
  Sys.readdir dir |> Array.to_list
  |> List.filter (fun file -> Filename.extension file = ".ll")
  |> List.fold_left
       (fun queue file ->
         let path = Filename.concat dir file in
         let membuf = ALlvm.MemoryBuffer.of_file path in
         (* skip invalid IR *)
         (* fix here llvm_irreader*)
         try push (Llvm_irreader.parse_ir llctx membuf, false) queue
         with _ -> queue)
       (Queue.create ())

(** make seedpool from Config.seed_dir. this queue contains, llmodule, covered, distance*)
let make_seedpool llctx =
  let dir = !Config.seed_dir in
  assert (Sys.file_exists dir && Sys.is_directory dir);
  let seedpool, seedset =
    Sys.readdir dir |> Array.to_list
    |> List.filter (fun file -> Filename.extension file = ".ll")
    |> List.fold_left
         (fun (queue, seedset) file ->
           let path = Filename.concat dir file in
           Coverage.Measurer.clean ();
           match Oracle.run_opt path with
           | CRASH | INVALID -> (queue, seedset)
           | VALID -> (
               let distance =
                 Coverage.Measurer.run () |> Coverage.Domain.CovSet.min_elt
               in
               let membuf = ALlvm.MemoryBuffer.of_file path in
               if distance == 0 then
                 try
                   ( push
                       (Llvm_irreader.parse_ir llctx membuf, true, distance)
                       queue,
                     seedset )
                 with _ -> (queue, seedset)
               else
                 try
                   ( queue,
                     SeedSet.add
                       (Llvm_irreader.parse_ir llctx membuf, distance)
                       seedset )
                 with _ -> (queue, seedset)))
         (Queue.create (), SeedSet.empty)
  in
  if Queue.is_empty seedpool then
    SeedSet.fold
      (fun (llm, distance) seedpool -> push (llm, false, distance) seedpool)
      seedset seedpool
  else seedpool
