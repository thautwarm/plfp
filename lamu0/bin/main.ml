open Lamu0.Lamu0_parser
open Lamu0.Lamu0_lex
open Lamu0.Lamu0_ast
open Printf
open Lexing

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let run_parser lexbuf =
  try
    prog read lexbuf
  with
  | Error ->
    fprintf stderr "%a: syntax error\n" print_position lexbuf;
    exit (-1)

let _ =
  let buf = Lexing.from_channel stdin in
  let bs = List.fold_right List.cons (run_parser buf) [] in
  List.iter (fun x -> show_ast @@ run (module SYMAst) x) bs