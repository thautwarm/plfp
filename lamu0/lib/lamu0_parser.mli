
(* The type of tokens. *)

type token = 
  | STRING of (string)
  | SEMICON
  | RP
  | LP
  | LET
  | INT of (string)
  | IN
  | ID of (string)
  | FN
  | FLOAT of (string)
  | EOF
  | ASSIGN
  | ARROW

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Final.SYMSelf.r list)
