let read_input s =
  s 
  |> String.split_on_char 'x'
  |> List.map int_of_string
  |> List.sort compare
  |> List.rev;;

let task1 s =
  let sides_to_num s =
    let lens = read_input s in
    let prod = lens |> Utils.list_prod in 
    let main_areas = lens |> List.map (fun n -> prod / n) in
    let small_area = main_areas |> List.hd in

    2 * Utils.list_sum main_areas + small_area
  in

  s
  |> List.map sides_to_num
  |> Utils.list_sum
;;

let task2 s =
  let sides_to_num s =
    let lens = read_input s in
    let small_lens = lens |> List.tl in
    let prod = lens |> Utils.list_prod in 
    
    2 * Utils.list_sum small_lens + prod
  in

  s
  |> List.map sides_to_num
  |> Utils.list_sum
;;

let instructions = Utils.file_to_lines ("../input/day2.txt") in
let result1 = task1 instructions in
let result2 = task2 instructions in
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %d\n" result2;
  assert (result1 = 1586300);
  assert (result2 = 3737498);