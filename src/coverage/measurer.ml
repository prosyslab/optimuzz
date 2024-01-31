module D = Domain
module F = Format

let clean () = Util.AUtil.clean !Config.cov_file

(* assume source codes are instrumented and `opt` are executed already *)
let run () =
  try
    let file = open_in !Config.cov_file in
    let target = D.Path.parse !Config.cov_directed in
    let dist l = D.Path.distance l target in
    let rec aux accu =
      match input_line file with
      | line ->
          let l = D.Path.parse line in
          aux (D.DistanceSet.add (dist l) accu)
      | exception End_of_file ->
          close_in file;
          if D.DistanceSet.is_empty accu then
            D.DistanceSet.singleton !Config.max_distance
          else accu
    in
    aux D.DistanceSet.empty
  with Sys_error _ -> D.DistanceSet.singleton !Config.max_distance
