type switch =
  | On 
  | Off 
  | Toggle
;;

type command = 
  {
    commandType : switch;
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
  let (ct, sr, sc, er, ec) = 
    if s |> String.starts_with ~prefix:"turn off " then 
      (Off, 2, 3, 5, 6)
    else if s |> String.starts_with ~prefix:"turn on " then
      (On, 2, 3, 5, 6)
    else
      (Toggle, 1, 2, 4, 5)
  in 
    {
      commandType = ct;
      start_row = sr |> List.nth list |> int_of_string;
      start_col = sc |> List.nth list |> int_of_string;
      end_row   = er |> List.nth list |> int_of_string;
      end_col   = ec |> List.nth list |> int_of_string;
    }
;;

let size = 1000;;

let cmd_map1 cmd light = 
  match cmd.commandType with 
  | On -> 1L 
  | Off  -> 0L 
  | Toggle -> Int64.sub 1L light;;

let cmd_map2 cmd light = 
  match cmd.commandType with 
  | On -> Int64.add light 1L
  | Off  -> Int64.sub light 1L |> Int64.max 0L
  | Toggle -> Int64.add light 2L
  ;;

let task cmd_map lines =
  let lights = Array.make_matrix size size 0L in 
  let index_vec = Array.init size Fun.id |> Array.to_seq in

  lines 
  |> List.map str_to_command
  |> List.iter (fun cmd ->
    for row = cmd.start_row to cmd.end_row do
      for col = cmd.start_col to cmd.end_col do
        lights.(row).(col) <- cmd_map cmd lights.(row).(col)
      done    
    done
  );
  
  index_vec
  |> Seq.map (fun row ->
    index_vec
    |> Seq.map (fun col -> lights.(row).(col))
    |> Utils.seq_sum64
  )
  |> Utils.seq_sum64
  ;;

let lines = Utils.file_to_lines "../input/day6.txt" in
let result1 = task cmd_map1 lines in
let result2 = task cmd_map2 lines in
  Printf.printf "Task1: %Ld\n" result1;
  Printf.printf "Task2: %Ld\n" result2;
  assert (result1 = 400410L); 
  assert (result2 = 15343601L); 
