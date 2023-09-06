let task s len =
  let prefix = String.make len '0' in
  let rec aux s num =
    let num_str = num |> string_of_int in
    let long_str = s ^ num_str in
    let digest = long_str |> Digest.string |> Digest.to_hex in 
    let is_ok = digest |> String.starts_with ~prefix:prefix in
    if is_ok then 
      num 
    else
      aux s (num + 1)
  in aux s 0
;;

let s = "bgvyzdsv" in
let result1 = task s 5 in
let result2 = task s 6 in
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %d\n" result2;
  assert (result1 = 254575);
  assert (result2 = 1038736);