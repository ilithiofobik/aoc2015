let to_num c =
  match c with 
  | '(' -> 1
  | ')' -> -1
  | _ -> 0;;

let task1 s =
  s 
  |> String.to_seq 
  |> Seq.map to_num 
  |> Seq.fold_left (+) 0
;;

let task2 s =
    let rec aux floor_count elem_count list =
      match (floor_count, list) with 
      | (-1, _)
      | (_, []) -> elem_count
      | (_, c::cs) -> aux (floor_count + to_num c) (elem_count + 1) cs
  in 
  s |> String.to_seq |> List.of_seq |> aux 0 0 
;;


let instructions = Utils.file_to_string ("../input/day1.txt") in
let final_floor = task1 instructions in
Printf.printf "%d" final_floor
