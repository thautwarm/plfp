
(* The type of tokens. *)

type token = 
  | STRING of (string)
  | SEMICOLON
  | RP
  | QUOTE
  | LP
  | LET
  | INT of (string)
  | IN
  | IMPLY
  | ID of (string)
  | FORALL
  | FN
  | FLOAT of (string)
  | EOF
  | DOT
  | COMMA
  | COLON
  | ASSIGN
  | ARROW

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Final.SYMSelf.r list)
