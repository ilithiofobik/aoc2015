let cond1 chars =
  chars
  |> List.filter (String.contains "aeiou")
  |> List.length 
  |> fun len -> len >= 3 ;;

let cond2 chars =
  let rec aux chars c1 = 
    match chars with 
    | (c2::cs) ->
      if c1 = c2 then true 
      else aux cs c2
    | [] -> false
  in 
  aux (chars |> List.tl) (chars |> List.hd) ;;

let rec cond3 chars =
  let expected = [ ('a', 'b'); ('c', 'd'); ('p', 'q'); ('x', 'y') ] in
  match chars with 
  | (c1::c2::cs) -> 
    if List.mem (c1, c2) expected then false 
    else cond3 (c2::cs)
  | _ -> true ;;

let rec cond4 chars =
  let get_all_pairs chars = 
    let rec aux chars list =
      match chars with 
      | (c1::c2::cs) -> aux (c2::cs) ((c1, c2)::list) 
      | _ -> list in 
    aux chars []
  in
  match chars with 
  | (c1::c2::cs) -> 
      let expected = get_all_pairs cs in
      if List.mem (c1, c2) expected then true 
      else cond4 (c2::cs)
  | _ -> false ;;

let cond5 chars =
  let rec aux chars c1 = 
    match chars with 
    | (c2::c3::cs) ->
      if c1 = c3 then true 
      else aux (c3::cs) c2
    | _ -> false 
  in 
  aux (chars |> List.tl) (chars |> List.hd) ;;

let is_nice1 chs = cond1 chs && cond2 chs && cond3 chs ;;
let is_nice2 chs = cond4 chs && cond5 chs ;;

let task lines is_nice =
  lines 
  |> List.map String.to_seq
  |> List.map List.of_seq
  |> List.filter is_nice
  |> List.length ;;

let lines = Utils.file_to_lines "../input/day5.txt" in
let result1 = task lines is_nice1 in
let result2 = task lines is_nice2 in 
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %d\n" result2;
  assert (result1 = 255);
  assert (result2 = 55);
