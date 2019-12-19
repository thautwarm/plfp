{
open Lexing
open Parser
exception SyntaxError of string
let pointer : string list ref = ref []
let push_ptr : string -> unit = fun s ->
  pointer := s :: !pointer

let c2s s = String.init 1 @@ fun _ -> s
type pstr_status = NonStr | StrEsc | StrNonEsc
}

let digit = ['0'-'9']
let decimal = digit+
let floatpoint = decimal '.' decimal
let white = [' ' '\t' '\n' '\r']+
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule read = parse
  | floatpoint { FLOAT (Lexing.lexeme lexbuf) }
  | decimal { INT (Lexing.lexeme lexbuf) }
  | "->" { ARROW }
  | "=>" { IMPLY }
  | "." {DOT}
  | "forall" { FORALL }
  | "let" {LET}
  | "in" {IN}
  | "fn" {FN}
  | id { ID (Lexing.lexeme lexbuf) }
  | white { read lexbuf }
  | '\'' { QUOTE }
  | '(' {LP}
  | ')' {RP}
  | ':' { COLON }
  | '=' { ASSIGN}
  | ',' { COMMA }
  | ';' { SEMICOLON }
  | "\"" {quotestr StrNonEsc lexbuf}
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | ";;" { EOF }
  | eof { EOF }

and quotestr pstr_status = parse
  | "\"" as a {
      match pstr_status with
      | NonStr -> quotestr StrNonEsc lexbuf
      | StrNonEsc ->
        let s = (String.concat "" @@ List.rev !pointer) in
        STRING s
      | StrEsc -> begin
        push_ptr @@ c2s a;
        quotestr StrNonEsc lexbuf
      end
  }
  | "\\" as a{
    match pstr_status with
    | StrNonEsc -> quotestr StrEsc lexbuf
    | StrEsc -> begin
        push_ptr @@ c2s a;
        quotestr StrNonEsc lexbuf
      end
    | _ -> failwith "expected impossible"
  }
  | eof {EOF}
  | _ as a {
    push_ptr @@ c2s a;
    quotestr pstr_status lexbuf
  }
