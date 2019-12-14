{
open Lexing
open Lamu0_parser
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
  | "let" { LET }
  | "in" { IN }
  | "fn" { FN }
  | ";" {SEMICON}
  (* | ':' { SEMICOLON } *)
  | "=>" { ARROW }
  | '=' { ASSIGN }
  | "\"" {quotestr StrNonEsc lexbuf}
  | "(" {LP}
  | ")" {RP}
  | white { read lexbuf }
  | id { ID (Lexing.lexeme lexbuf) }
  | _ as s { failwith @@ c2s s }
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
  | _ as a {
    push_ptr @@ c2s a;
    quotestr pstr_status lexbuf
  }
  | eof {EOF}
