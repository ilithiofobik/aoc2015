type commandType =
  | On 
  | Off 
  | Toggle
;;

type command = 
  {
    commandType : commandType;
    start_row : int;
    start_col : int;
    end_row : int;
    end_col : int;
  }
;;

let str_to_command s =
  let list =
    s 
    |> String.map (fun c -> match c with | ',' -> ' ' | x -> x) 
    |> String.split_on_char ' '
  in
  if s |> String.starts_with ~prefix:"turn off " then 
    {
      commandType = Off;
      start_row = List.nth list  2 |> int_of_string;
      start_col = List.nth list  3 |> int_of_string;
      end_row = List.nth list  5 |> int_of_string;
      end_col = List.nth list  6 |> int_of_string;
    }
  else if s |> String.starts_with ~prefix:"turn on " then 
    {
      commandType = On;
      start_row = List.nth list  2 |> int_of_string;
      start_col = List.nth list  3 |> int_of_string;
      end_row = List.nth list  5 |> int_of_string;
      end_col = List.nth list  6 |> int_of_string;
    }
  else 
    {
      commandType = Toggle;
      start_row = List.nth list  1 |> int_of_string;
      start_col = List.nth list  2 |> int_of_string;
      end_row = List.nth list  4 |> int_of_string;
      end_col = List.nth list  5 |> int_of_string;
    }
;;

let cmd_check cmd (row, col) = 
  cmd.start_row <= row && 
  row <= cmd.end_row && 
  cmd.start_col <= col && 
  col <= cmd.end_col;;

let cmd_map cmd light = 
  match cmd.commandType with 
  | On -> true 
  | Off  -> false 
  | Toggle -> not light;;

let task1 lines =
  let lights = Array.make_matrix 1000 1000 false in 
  let index_vec = List.init 1000 (fun n -> n) in 
  let index_matrix = Utils.list_cartesian index_vec index_vec in 

  lines 
  |> List.map str_to_command
  |> List.iter (fun cmd ->
    index_matrix 
    |> List.filter (cmd_check cmd)
    |> List.iter (fun (row, col) ->
        lights.(row).(col) <- cmd_map cmd lights.(row).(col)
      )
    );

  index_matrix
  |> List.filter (fun (row, col) -> lights.(row).(col))
  |> List.length  
  ;;
  
let cmd_map2 cmd light = 
  match cmd.commandType with 
  | On -> light + 1 
  | Off  -> max (light - 1) 0 
  | Toggle -> light + 2
  ;;

let task2 lines =
  let lights = Array.make_matrix 1000 1000 0 in 
  let index_vec = List.init 1000 (fun n -> n) in 
  let index_matrix = Utils.list_cartesian index_vec index_vec in 
  let index_matrix_seq = List.to_seq index_matrix in

  lines 
  |> List.map str_to_command
  |> List.iter (fun cmd ->
    index_matrix 
    |> List.filter (cmd_check cmd)
    |> List.iter (fun (row, col) ->
        lights.(row).(col) <- cmd_map2 cmd lights.(row).(col)
      )
    );

  index_matrix_seq
  |> Seq.map (fun (row, col) -> lights.(row).(col))
  |> Seq.map Int64.of_int
  |> Seq.fold_left Int64.add Int64.zero
  ;;

let lines = Utils.file_to_lines "../input/day6.txt" in
let result1 = task1 lines in
let result2 = task2 lines in
  Printf.printf "Task1: %d\n" result1;
  Printf.printf "Task2: %Ld\n" result2;
  assert (result1 = 400410); 
  assert (result2 = 15343601L); 
