module IntPair = 
  struct 
    type t = int * int
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

let task1 chars =
  let trace = IntPairSet.singleton (0, 0) in
  let rec aux w h trace input =
  match input with 
  | [] -> trace
  | c::cs -> 
    let (nw, nh) = move w h c in 
    let new_trace = IntPairSet.add (nw, nh) trace in
    aux nw nh new_trace cs
  in
  chars
  |> aux 0 0 trace
  |> IntPairSet.cardinal
;;

let task2 chars =
  let trace = IntPairSet.singleton (0, 0) in
  let rec aux w h rw rh r trace input =
  match input with 
  | [] -> trace
  | c::cs -> 
    if r then
      let (nrw, nrh) = move rw rh c in 
      let new_trace = IntPairSet.add (nrw, nrh) trace in
      aux w h nrw nrh (not r) new_trace cs
    else 
      let (nw, nh) = move w h c in 
      let new_trace = IntPairSet.add (nw, nh) trace in
      aux nw nh rw rh (not r) new_trace cs
  in
  chars
  |> aux 0 0 0 0 true trace
  |> IntPairSet.cardinal
;;

let chars = Utils.file_to_chars ("../input/day3.txt") in
let result1 = task1 chars in
let result2 = task2 chars in
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %d\n" result2;
  assert (result1 = 2572);
  assert (result2 = 2631);