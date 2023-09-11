module StrMap = Map.Make(struct type t = string let compare = compare end)

type expression =
  | Value of string
  | And of string * string 
  | Or of string * string 
  | LShift of string * string
  | RShift of string * string
  | Not of string;;

let string_to_cmd s =
  let words = String.split_on_char ' ' s in
  match words with
  | [ num; "->"; to_wire ] -> (to_wire, Value num)
  | [ "NOT"; x; "->"; to_wire ] -> (to_wire, Not x)
  | [ x; "AND"; y; "->"; to_wire ] -> (to_wire, And (x, y))
  | [ x; "OR"; y; "->"; to_wire ] -> (to_wire, Or (x, y))
  | [ x; "LSHIFT"; y; "->"; to_wire ] -> (to_wire, LShift (x, y))
  | [ x; "RSHIFT"; y; "->"; to_wire ] -> (to_wire, RShift (x, y))
  | _ -> failwith "Invalid input";;

let rec find_cmd key cmd_map  left right = 
  (* Printf.printf "Searching for %s in [%d, %d]\n" key left right; *)
  if left = right then
    let (k, v) = cmd_map .(left) in
    if k = key then v
    else failwith "Not found"
  else
    let center = (left + right) / 2 in
    let (k, v) = cmd_map .(center) in
    if k = key then v
    else if k < key then find_cmd key cmd_map  (center + 1) right
    else find_cmd key cmd_map  left (center - 1);;

let rec evaluate cmd_map s str_map =
  match int_of_string_opt s with
  | Some n -> n
  | None ->
    match StrMap.find_opt s !str_map with
    | Some n -> n
    | None ->
      let cmd = StrMap.find s cmd_map in
      let value =
        match cmd with
        | Value x -> evaluate cmd_map x str_map
        | Not x -> lnot (evaluate cmd_map x str_map)
        | And (x, y) -> (evaluate cmd_map x str_map) land (evaluate cmd_map y str_map)
        | Or (x, y) -> (evaluate cmd_map x str_map) lor (evaluate cmd_map y str_map)
        | LShift (x, y) -> (evaluate cmd_map x str_map) lsl (evaluate cmd_map y str_map)
        | RShift (x, y) -> (evaluate cmd_map x str_map) lsr (evaluate cmd_map y str_map)
      in 
      str_map := StrMap.add s value !str_map;
      value;;

let task cmd_map =
  let str_map = ref StrMap.empty in
  evaluate cmd_map "a" str_map;;

let cmd_map1 = ref StrMap.empty in 
Utils.file_to_lines "../input/day7.txt"
|> List.map string_to_cmd 
|> List.iter (fun (k, v) -> cmd_map1 := StrMap.add k v !cmd_map1);
let cmd_map2 = StrMap.add "b" (Value "3176") !cmd_map1 in
let result1 = task !cmd_map1 in
let result2 = task cmd_map2 in
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %d\n" result2;
  assert (result1 = 3176); 
  assert (result2 = 14710); 
  ()
