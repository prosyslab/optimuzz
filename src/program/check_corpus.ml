open Oracle

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

let speclist =
  [ ("-ntasks", Arg.Int (fun n -> ntasks := n), "the degree of parallelism") ]

let _ =
  let open Domainslib in
  Arg.parse speclist
    (fun arg -> args := arg :: !args)
    "usage: check-corpus <dir> [options]";

  let dir = !args |> List.hd in

  let llfiles = collect_module_files dir in
  Format.printf "Found %d modules@." (Array.length llfiles);

  let pool = Task.setup_pool ~num_domains:!ntasks () in

  Task.parallel_for pool ~start:0 ~finish:(Array.length llfiles) ~body:(fun i ->
      let llfile = llfiles.(i) in
      let verify = check_transformation llfile in
      if verify then ()
      else Format.printf "alive-tv reports wrong transformation: %s@." llfile);
  ()
