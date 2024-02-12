open Oracle
open Util

let collect_module_files ?predicate dir =
  let predicate = match predicate with Some f -> f | None -> fun _ -> true in
  Sys.readdir dir
  |> Array.to_list
  |> List.filter (fun f ->
         if Filename.check_suffix f "opt.ll" then false
         else if Filename.check_suffix f "ll" then true
         else false)
  |> List.map (fun f -> Filename.concat dir f)
  |> List.filter predicate
  |> Array.of_list

(** [check_transformation llfile] returns
 *  if optimized module of [llfile] refines the module of [llfile]*)
let check_transformation llfile =
  let llfile_opt = Filename.chop_suffix llfile "ll" ^ "opt.ll" in
  match Optimizer.run ~passes:[ "instcombine" ] ~output:llfile_opt llfile with
  | CRASH -> failwith ("Crashing module:" ^ llfile)
  | INVALID | VALID _ -> (
      (* coverage is not required *)
      match Validator.run llfile llfile_opt with
      | Correct | Failed | Errors -> true
      | Incorrect -> false)

let time f x =
  let t = Sys.time () in
  let y = f x in
  (y, Sys.time () -. t)

let args = ref []
let ntasks = ref 12
let re = ref None

let speclist =
  [
    ("-ntasks", Arg.Int (fun n -> ntasks := n), "the degree of parallelism");
    ( "-re",
      Arg.String (fun s -> re := Some (Str.regexp s)),
      "regular expression to filter files" );
  ]

let bar ~total =
  let open Progress.Line in
  list [ bar total; count_to total ]

module C = Domainslib.Chan

let report_worker reporter (queue : int64 C.t) () =
  let rec iter () =
    let _ = C.recv queue in
    reporter 1L;
    iter ()
  in
  iter () |> ignore

let grep re filename =
  let content = AUtil.readlines filename in
  List.exists (fun line -> Str.string_match re line 0) content

let _ =
  let open Domainslib in
  Arg.parse speclist
    (fun arg -> args := arg :: !args)
    "usage: check-corpus <dir> [options]";

  let dir = !args |> List.hd in

  let llfiles =
    match !re with
    | None -> collect_module_files dir
    | Some re -> collect_module_files ~predicate:(grep re) dir
  in

  let num_files = Array.length llfiles in
  Format.printf "Found %d modules@." num_files;

  let pool = Task.setup_pool ~num_domains:!ntasks () in

  let report_queue = C.make_unbounded () in
  Progress.with_reporter
    (Progress.counter (Int64.of_int num_files))
    (fun reporter ->
      let report_domain = Domain.spawn (report_worker reporter report_queue) in

      Task.parallel_for pool ~start:0 ~finish:(num_files - 1) ~body:(fun i ->
          let llfile = llfiles.(i) in
          let verify = check_transformation llfile in
          C.send report_queue 1L;
          if not verify then
            Format.printf "alive-tv reports wrong transformation: %s@." llfile);

      Domain.join report_domain);

  Task.teardown_pool pool;
  ()
