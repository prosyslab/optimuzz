open Oracle
open Util
open Domainslib
module L = Logger

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
  let llfile_opt =
    let basename = Filename.basename llfile in
    let filename_opt = Filename.chop_suffix basename "ll" ^ "opt.ll" in
    "tmp" ^ Filename.dir_sep ^ filename_opt
  in

  (* HACK: both min and avg has same implementation of [ cover_target ] *)
  let module Optimizer = Optimizer (Coverage.Avg_dist) in
  match Optimizer.run ~passes:[ "instcombine" ] ~output:llfile_opt llfile with
  | CRASH -> failwith ("Crashing module:" ^ llfile)
  | INVALID | VALID _ -> (
      try
        (* coverage is not required *)
        match Validator.run llfile llfile_opt with
        | Correct | Failed | Errors -> true
        | Incorrect -> false
      with Unix.Unix_error _ -> true)

let bar ~total =
  let open Progress.Line in
  list [ elapsed (); bar total; count_to total; percentage_of total ]

let report_worker reporter times (chan : unit Chan.t) () =
  let rec iter t =
    if t = 0 then ()
    else
      let _ = Chan.recv chan in
      reporter 1;
      iter (t - 1)
  in
  iter times

let grep re filename =
  let content = AUtil.readlines filename in
  List.exists (fun line -> Str.string_match re line 0) content

let mv src dir = Sys.rename src (dir ^ Filename.dir_sep ^ Filename.basename src)

let _ =
  Arg.parse speclist
    (fun arg -> args := arg :: !args)
    "usage: check-corpus <out-dir> [options]";

  (try Sys.mkdir "tmp" 0o777
   with Sys_error _ ->
     Sys.command "rm -rf tmp" |> ignore;
     Sys.mkdir "tmp" 0o777);

  let out_dir = !args |> List.hd in
  let corpus_dir = Filename.concat out_dir "corpus" in
  let crash_dir = Filename.concat out_dir "crash" in

  let log_file = Filename.concat out_dir "check-corpus.log" in
  L.from_file log_file;
  L.set_level L.ERROR;

  let llfiles =
    match !re with
    | None -> collect_module_files corpus_dir
    | Some re -> collect_module_files ~predicate:(grep re) corpus_dir
  in

  let num_files = Array.length llfiles in

  let pool = Task.setup_pool ~num_domains:!ntasks () in

  let report_chan = Chan.make_unbounded () in

  Progress.with_reporter (bar ~total:num_files) (fun reporter ->
      Task.run pool (fun () ->
          let counter =
            Task.async pool (report_worker reporter num_files report_chan)
          in
          Task.parallel_for pool ~start:0 ~finish:(num_files - 1)
            ~body:(fun i ->
              let llfile = llfiles.(i) in
              let verify = check_transformation llfile in
              Chan.send report_chan ();
              if not verify then mv llfile crash_dir);

          Task.await pool counter));

  Task.teardown_pool pool;
  L.finalize ();
  ()
