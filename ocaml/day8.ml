type state =
  | Normal 
  | Escaped 
  | Hex1 
  | Hex2
;;

let rec evaluate1 state diff chars =
  match chars, state with
  | [], _ -> diff
  | '\\'::cs, Normal -> evaluate1 Escaped (diff + 1) cs
  | '\"'::cs, Normal -> evaluate1 Normal  (diff + 1) cs
  | c::cs, Normal    -> evaluate1 Normal  diff cs 
  | 'x'::cs, Escaped -> evaluate1 Hex1    (diff + 1) cs 
  | c::cs, Escaped   -> evaluate1 Normal  diff cs
  | c::cs, Hex1      -> evaluate1 Hex2    (diff + 1) cs 
  | c::cs, Hex2      -> evaluate1 Normal  diff cs;;

let rec evaluate2 diff chars =
  match chars with
  | []       -> 2 + diff
  | '\"'::cs -> evaluate2 (diff + 1) cs
  | '\\'::cs -> evaluate2 (diff + 1) cs
  | c::cs    -> evaluate2 diff cs;;

let task lines mapping =
  lines 
  |> List.map (fun line -> line |> String.to_seq |> List.of_seq)
  |> List.map mapping
  |> Utils.list_sum;;

let lines = Utils.file_to_lines "../input/day8.txt" in
let result1 = task lines (evaluate1 Normal 0) in
let result2 = task lines (evaluate2 0) in
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %d\n" result2;
  assert (result1 = 1350); 
  assert (result2 = 2085); 
  ()