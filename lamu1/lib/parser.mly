%{
open Final
module Exp = Final.SYMSelf
module Typ = Type_final.SYMSelf
%}

%token LET
%token IN
%token FN
%token LP
%token RP
%token COMMA
%token IMPLY
%token ARROW
%token ASSIGN
%token COLON
%token FORALL
%token QUOTE
%token DOT
%token <string>INT
%token <string>FLOAT
%token <string>STRING
%token <string>ID
%token SEMICOLON
%token EOF

%start <Final.SYMSelf.r list> prog

%%

prog: stmts=separated_list(SEMICOLON, expr) EOF {stmts}
;

expr:
    LET n=ID ASSIGN bound=expr IN body=expr {Exp.letl n None bound body}
  | LET n=ID COLON t=typ ASSIGN bound=expr IN body=expr {Exp.letl n (Some t) bound body}
  | FN n=ID IMPLY body=expr {Exp.lam n body}
  | a=app {a}
  ;

app:
    f=app a=atom {Exp.app f a}
  | a=atom {a}
  ;

atom:
    a=INT  {Exp.lit IntT a}
  | a=FLOAT {Exp.lit FloatT a}
  | a=STRING {Exp.lit StringT a}
  | a=ID {Exp.var a}
  | LP nest=expr RP {nest}
  ;


(* grammar typ is from https://github.com/RemuLang/remu-type-system/blob/master/lib/rets_parser.mly *)

typ:
  | tapp=typeapp {tapp}
  | arg=typlit ARROW ret=typ { Typ.arrow arg ret}
  (*  | LB elts=separated_list(COMMA, typ) RB {Tuple elts} *)
  | FORALL ns=separated_list(COMMA, freshtype) DOT ty=typ {Typ.forall ns ty}
  (*  | LBB fs=rowtyp RBB {Record(fs)} *)
  (*  | LBB witness=typ RBB IMPLY bounded=typ {Implicit(witness, bounded)} *)
  ;

typeapp:
  | f=typeapp arg=typlit {Typ.app f arg}
  | a=typlit {a}
  ;

freshtype: QUOTE a=ID {a}
  ;

typlit:
  | tid=ID {Typ.nom tid}
  | QUOTE a=ID {Typ.fresh a}
  | LP nest=typ RP {nest}
  ;

(* rowtyp: fs=separated_list(COMMA, rowfield) tl=option(rowtail) {
      begin match tl with
      | Some tl -> RowPoly tl
      | _ -> RowMono
      end |> record fs
  }
  ;
rowtail: OR b=typ {b}

rowfield:
  | k=ID COLON v=typ {(k, v)}
;
*)
