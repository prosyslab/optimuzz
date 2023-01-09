open Language
module F = Format

let rec generate_program size =
  assert (size > 0);
  if size = 1 then
    let idx = Random.int (List.length terminals) in
    List.nth terminals idx
  else if size <= 3 then
    if Random.bool () then Plus (generate_program 1, generate_program 1)
    else Minus (generate_program 1, generate_program 1)
  else
    match Random.int 3 with
    | 0 ->
        let r = Random.int (size - 1) + 1 in
        Plus (generate_program r, generate_program (size - r))
    | 1 ->
        let r = Random.int (size - 1) + 1 in
        Minus (generate_program r, generate_program (size - r))
    | _ ->
        let r1 = Random.int (size - 3) + 2 in
        let r2 = Random.int (size - 1 - r1) + 1 in
        If
          ( generate_bexp r1,
            generate_program r2,
            generate_program (size - r1 - r2) )

and generate_bexp size =
  assert (size > 1);
  if Random.bool () then
    let r = Random.int (size - 1) + 1 in
    Le (generate_program r, generate_program (size - r))
  else
    let r = Random.int (size - 1) + 1 in
    Eq (generate_program r, generate_program (size - r))

let generate_example pgm size =
  List.init size (fun _ -> (Random.int 200 - 100, Random.int 200 - 100))
  |> List.iter (fun (x, y) -> F.printf "%d,%d,%d\n" x y (eval pgm x y))
