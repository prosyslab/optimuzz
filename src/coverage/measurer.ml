open Domain
module F = Format

let clean () = Util.AUtil.clean !Config.cov_file

(* assume source codes are instrumented and `opt` are executed already *)
let run () =
  try
    let file = open_in !Config.cov_file in
    let target = Line.parse !Config.cov_directed in
    let dist l = Line.distance l target in
    let rec aux accu =
      match input_line file with
      | line ->
          let l = Line.parse line in
          aux (DistanceSet.add (dist l) accu)
      | exception End_of_file ->
          close_in file;
          if DistanceSet.is_empty accu then
            DistanceSet.singleton !Config.max_distance
          else accu
    in
    aux DistanceSet.empty
  with Sys_error _ -> DistanceSet.singleton !Config.max_distance
