module IntPair = struct 
  type t = int * int
  (* use Pervasives compare *)
  let compare = compare
end

module IntPairSet = Set.Make(IntPair)

let move width height c =
  match c with 
  | '^' -> width, (height + 1)
  | '>' -> (width + 1), height
  | 'v' -> width, (height - 1)
  | '<' -> (width - 1), height
  | _   -> failwith "Unknown character";;

let task1 s =
  let rec aux w h trace input =
  match input with 
  | [] -> trace
  | c::cs -> 
    let (nw, nh) = move w h c in 
    aux nw nh ((nw, nh)::trace)  cs
  in
  s 
  |> String.to_seq
  |> List.of_seq 
  |> aux 0 0 [(0, 0)] 
  |> IntPairSet.of_list 
  |> IntPairSet.cardinal
;;

let task2 s =
  let rec aux w h rw rh r trace input =
  match input with 
  | [] -> trace
  | c::cs -> 
    if r then
      let (nrw, nrh) = move rw rh c in 
      aux w h nrw nrh (not r) ((nrw, nrh)::trace) cs
    else 
      let (nw, nh) = move w h c in 
      aux nw nh rw rh (not r) ((nw, nh)::trace) cs
  in
  s 
  |> String.to_seq
  |> List.of_seq 
  |> aux 0 0 0 0 true [(0, 0)] 
  |> IntPairSet.of_list 
  |> IntPairSet.cardinal
;;

let input = Utils.file_to_string ("../input/day3.txt") in
let result1 = task1 input in
let result2 = task2 input in
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %d\n" result2;
  assert (result1 = 2572);
  assert (result2 = 2631);