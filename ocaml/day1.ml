let to_num c =
  match c with 
  | '(' -> 1
  | ')' -> -1
  | _   -> failwith "Unknown character";;

let task1 s =
  s 
  |> String.to_seq 
  |> Seq.map to_num 
  |> Seq.fold_left (+) 0;;

let task2 s =
    let rec aux floor pos list =
      match (floor, list) with 
      | (-1, _)
      | (_, []) -> pos
      | (_, c::cs) -> aux (floor + to_num c) (pos + 1) cs
  in 
  s |> String.to_seq |> List.of_seq |> aux 0 0;;


let instructions = Utils.file_to_string ("../input/day1.txt") in
let final_floor = task1 instructions in
Printf.printf "%d" final_floor
