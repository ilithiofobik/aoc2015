let file_to_list filename =
  let channel = open_in filename in
  let rec read_lines lines =
    try
      let line = input_line channel in
      read_lines (line :: lines)
    with
    | End_of_file ->
      close_in channel;
      List.rev lines
  in
  read_lines []
;;

let file_to_string filename =
  filename |> file_to_list |> String.concat ""
;;