let to_num c =
  match c with 
  | '(' -> 1
  | ')' -> -1
  | _   -> failwith "Unknown character";;

let task1 chars =
  chars
  |> List.map to_num 
  |> List.fold_left (+) 0;;

let task2 chars =
    let rec aux floor pos list =
      match (floor, list) with 
      | (-1, _)
      | (_, []) -> pos
      | (_, c::cs) -> aux (floor + to_num c) (pos + 1) cs
  in 
  chars |> aux 0 0;;

  let chars = Utils.file_to_chars ("../input/day1.txt") in
  let result1 = task1 chars in
  let result2 = task2 chars in
    Printf.printf "Task1: %d\n" result1;
    Printf.printf "Task2: %d\n" result2;
    assert (result1 = 138);
    assert (result2 = 1771);