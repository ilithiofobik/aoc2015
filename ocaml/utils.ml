let file_to_list filename =
  let channel = open_in filename in
  let rec read_lines lines =
    try
      let line = input_line channel in
      read_lines (line :: lines)
    with
    | End_of_file ->
      close_in channel;
      lines |> List.rev |> List.map String.trim
  in
  read_lines []
;;

let file_to_string filename =
  filename |> file_to_list |> String.concat ""
;;

let list_sum list =
  list |> List.fold_left (+) 0
;;

let list_prod list =
  list |> List.fold_left (fun a b -> a * b) 1
;;