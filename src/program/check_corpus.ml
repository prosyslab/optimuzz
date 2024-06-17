open Oracle
open Util
open Domainslib
module L = Logger

let args = ref []
let ntasks = ref 12
let re = ref None
let tv_bin = ref "./alive-tv"

let optimizer_passes =
  (* ref [ "globaldce"; "simplifycfg"; "instsimplify"; "instcombine" ] *)
  ref [ "instcombine" ]

let speclist =
  [
    ("-ntasks", Arg.Int (fun n -> ntasks := n), "the degree of parallelism");
    ( "-re",
      Arg.String (fun s -> re := Some (Str.regexp s)),
      "regular expression to filter files" );
    ( "-passes",
      Arg.String
        (function s -> optimizer_passes := String.split_on_char ',' s),
      "Set opt passes" );
    ("-tv-bin", Arg.String (fun s -> tv_bin := s), "alive-tv binary");
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
let check_transformation tmp_dir llfile =
  let llfile_opt =
    let basename = Filename.basename llfile in
    let filename_opt = Filename.chop_suffix basename "ll" ^ "opt.ll" in
    tmp_dir ^ Filename.dir_sep ^ filename_opt
  in

  match Optimizer.run ~passes:!optimizer_passes ~output:llfile_opt llfile with
  | Error Optimizer.Non_zero_exit -> failwith ("Crashing module:" ^ llfile)
  | Error Optimizer.Hang -> failwith ("Crashing module:" ^ llfile)
  | Error Optimizer.Cov_not_generated | Ok _ -> (
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
  Printexc.record_backtrace true;
  Arg.parse speclist
    (fun arg -> args := arg :: !args)
    "usage: check-corpus <out-dir> [options]";

  Config.alive_tv_bin := !tv_bin;

  let out_dir = !args |> List.hd in
  let corpus_dir = Filename.concat out_dir "corpus" in
  let crash_dir = Filename.concat out_dir "crash" in
  let tmp_dir = Filename.concat out_dir "tmp" in

  Sys.command ("mkdir -p " ^ tmp_dir) |> ignore;

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
              let verify = check_transformation tmp_dir llfile in
              Chan.send report_chan ();
              if not verify then mv llfile crash_dir);

          Task.await pool counter));

  Task.teardown_pool pool;
  L.finalize ();
  ()
