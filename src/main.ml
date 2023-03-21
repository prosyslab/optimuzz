module F = Format

type opt_res_t = CRASH | INVALID | VALID

let llctx = Llvm.create_context ()
let count = ref 0

(* for logging *)
let alive2_log = "alive-tv.txt"
let timestamp = "timestamp.txt"
let start_time = ref 0
let recent_time = ref 0
let timestamp_fp = open_out timestamp

(* helpers *)
let concat_home s = Filename.concat !Config.project_home s
let ll_of_count () = string_of_int !count ^ ".ll"
let now () = Unix.time () |> int_of_float

module SeedPool = struct
  type t = Llvm.llmodule Queue.t

  let push s pool =
    Queue.push s pool;
    pool

  let pop pool = (Queue.pop pool, pool)
  let cardinal = Queue.length

  let of_dir dir =
    assert (Sys.file_exists dir && Sys.is_directory dir);
    Sys.readdir dir |> Array.to_list
    |> List.filter (fun file -> Filename.extension file = ".ll")
    |> List.fold_left
         (fun queue file ->
           Filename.concat dir file |> Llvm.MemoryBuffer.of_file
           |> Llvm_irreader.parse_ir llctx
           |> Fun.flip push queue)
         (Queue.create ())
end

module Coverage = struct
  module FNameMap = Map.Make (String)
  module LineSet = Set.Make (Int)

  type t = LineSet.t FNameMap.t

  let empty = FNameMap.empty
  let add = FNameMap.add
  let empty_set = LineSet.empty
  let add_set = LineSet.add

  (** [join x y] adds all coverage in [y] into [x]. *)
  let join x y =
    FNameMap.merge
      (fun _ d_x d_y ->
        match (d_x, d_y) with
        | Some d_x, Some d_y -> Some (LineSet.union d_x d_y)
        | Some d, None | None, Some d -> Some d
        | None, None -> None)
      x y

  (** [is_sub x y] returns whether [y] is a total subset of [x]. *)
  let is_sub x y =
    FNameMap.for_all
      (fun k d_y ->
        match FNameMap.find_opt k x with
        | Some d_x -> LineSet.subset d_y d_x
        | None -> false)
      y

  (** [total_cardinal x] returns the sum of cardinals of all bindings in [x]. *)
  let total_cardinal x =
    FNameMap.fold (fun _ d accu -> accu + LineSet.cardinal d) x 0

  let print x =
    print_endline "[";
    FNameMap.iter
      (fun k d ->
        print_string k;
        print_string ": {";
        LineSet.iter
          (fun elem ->
            print_int elem;
            print_string " ")
          d;
        print_endline "}")
      x;
    print_endline "]"
end

let initialize () =
  Arg.parse Config.opts
    (fun _ -> failwith "There must be no anonymous arguments.")
    "Usage: llfuzz [options]";

  (* these files are bound to llfuzz project *)
  Config.project_home :=
    Sys.argv.(0) |> Unix.realpath |> Filename.dirname |> Filename.dirname
    |> Filename.dirname |> Filename.dirname;
  Config.opt_bin := concat_home !Config.opt_bin;
  Config.alive2_bin := concat_home !Config.alive2_bin;

  (* these files are bound to (outer) workspace *)
  (try Sys.mkdir !Config.out_dir 0o755 with _ -> ());
  (try Sys.mkdir !Config.crash_dir 0o755 with _ -> ());

  Random.init !Config.random_seed

let get_coverage () =
  List.iter
    (fun elem ->
      let llvm_pid =
        Unix.create_process "llvm-cov"
          [| "llvm-cov"; "gcov"; elem |]
          Unix.stdin Unix.stdout Unix.stderr
      in
      Unix.waitpid [] llvm_pid |> ignore)
    (Lazy.force Config.gcda_list);
  let rec aux fp accu =
    try
      (* each line is the form of [COVERED_TIMES:LINE_NUM:CODE] *)
      let chunks = String.split_on_char ':' (input_line fp) in
      if
        (try chunks |> List.hd |> String.trim |> int_of_string
         with Failure _ -> -1)
        > 0
      then
        aux fp
          (Coverage.add_set
             (List.nth chunks 1 |> String.trim |> int_of_string)
             accu)
      else aux fp accu
    with End_of_file ->
      close_in fp;
      accu
  in
  List.fold_left
    (fun accu elem ->
      Coverage.add elem (aux (open_in elem) Coverage.empty_set) accu)
    Coverage.empty
    (Lazy.force Config.gcov_list)

let run_alive2 filename =
  (* run alive2 *)
  let pid =
    Unix.create_process !Config.alive2_bin
      [| !Config.alive2_bin; filename |]
      Unix.stdin
      (Unix.openfile alive2_log [ O_CREAT; O_WRONLY ] 0o640)
      Unix.stderr
  in
  Unix.waitpid [] pid |> ignore;

  (* review result *)
  let file = open_in alive2_log in
  let rec loop accu =
    try loop (input_line file :: accu) with End_of_file -> accu
  in
  (* FIXME: magic number *)
  let all_lines = loop [] |> List.rev |> List.filteri (fun i _ -> i < 6) in
  close_in file;
  let search src tgt =
    let re_tgt = Str.regexp_string tgt in
    try Str.search_forward re_tgt src 0 with Not_found -> -1
  in
  let rec aux accu = function
    | [] -> accu
    | hd :: tl ->
        if
          search hd "failed-to-prove transformations" = -1
          || hd |> String.split_on_char ' ' |> Fun.flip List.nth 0
             |> int_of_string = 0
        then
          if
            search hd "incorrect transformations" = -1
            || hd |> String.split_on_char ' ' |> Fun.flip List.nth 0
               |> int_of_string = 0
          then aux accu tl
          else INVALID
        else CRASH
  in
  aux VALID all_lines

let run llm =
  (* reset all previous coverages *)
  (* FIXME: magic path *)
  ignore
    (Sys.command
       ("find "
       ^ concat_home "./llvm-project/build/"
       ^ " -type f -name '*.gcda' | xargs rm"));

  count := !count + 1;
  let output_name = Filename.concat !Config.out_dir (ll_of_count ()) in
  Llvm.print_module output_name llm;

  (* run opt/alive2 and evaluate *)
  if !Config.no_tv then (
    let exit_code =
      Sys.command (!Config.opt_bin ^ " -S --passes=instcombine " ^ output_name)
    in
    let crashed = exit_code <> 0 in
    if crashed then
      Llvm.print_module (Filename.concat !Config.crash_dir (ll_of_count ())) llm;
    ((if crashed then CRASH else VALID), get_coverage ()))
  else
    let alive2_result = run_alive2 output_name in
    if alive2_result <> VALID then
      Llvm.print_module (Filename.concat !Config.crash_dir (ll_of_count ())) llm;
    (alive2_result, get_coverage ())

let rec fuzz pool coverage =
  let seed, pool_popped = SeedPool.pop pool in
  (* update pool, coverage, and crashes
     by generating n mutants from single seed *)
  let pool_new, coverage_new =
    Utils.repeat_fun
      (fun (p, co) ->
        (* a mutant is mutated n times from the seed *)
        let mutant =
          Utils.repeat_fun
            (fun llm -> Mutation.run llctx llm)
            seed !Config.mutate_times
        in
        (* TODO: not using crash flag during fuzzing? *)
        let _, co' = run mutant in
        let p_step =
          if Coverage.is_sub co co' then p else SeedPool.push mutant p
        in
        let co_step = Coverage.join co co' in

        if now () - !recent_time > !Config.log_time then (
          recent_time := now ();
          output_string timestamp_fp
            (string_of_int (now () - !start_time)
            ^ " "
            ^ string_of_int (Coverage.total_cardinal co_step)
            ^ "\n"));

        (p_step, co_step))
      (pool_popped, coverage) !Config.fuzzing_times
  in
  (* repeat until the time budget or seed pool exhausts *)
  if
    now () - !start_time > !Config.time_budget || SeedPool.cardinal pool_new = 0
  then coverage_new
  else fuzz pool_new coverage_new

let main () =
  initialize ();
  let seed_pool = SeedPool.of_dir !Config.seed_dir in
  F.printf "#seeds: %d\n" (SeedPool.cardinal seed_pool);

  start_time := now ();
  let coverage = fuzz seed_pool Coverage.empty in
  let end_time = now () in

  ignore (Sys.command "rm *.gcov");
  if not !Config.no_tv then Unix.unlink alive2_log;

  F.printf "total coverage: %d lines\n" (Coverage.total_cardinal coverage);
  F.printf "time spend: %ds\n" (end_time - !start_time)

let _ = main ()
