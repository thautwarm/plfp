%{
open Final
open Final.SYMSelf
open Remu_ts.Infer
%}

%token LET
%token IN
%token FN
%token LP
%token RP
%token LB
%token RB
%token LBB
%token RBB
%token COMMA
%token IMPLY
%token ARROW
%token ASSIGN
%token COLON
%token FORALL
%token QUOTE
%token OR
%token <string>INT
%token <string>FLOAT
%token <string>STRING
%token <string>ID
%token SEMICON
%token EOF

%start <Final.SYMSelf.r list> prog

%%


prog: stmts=separated_list(SEMICON, expr) EOF {stmts};

expr:
    LET n=ID ASSIGN bound=expr IN body=expr {letl n None bound body}
  | LET n=ID COLON t=typ ASSIGN bound=expr IN body=expr {letl n (Some t) bound body}
  | FN n=ID ARROW body=expr {lam n body}
  | a=app {a}
  ;

app:
    f=app a=atom {app f a}
  | a=atom {a}
  ;

atom:
    a=INT  {lit IntT a}
  | a=FLOAT {lit FloatT a}
  | a=STRING {lit StringT a}
  | a=ID {var a}
  | LP nest=expr RP {nest}
  ;


(* grammar typ is from https://github.com/RemuLang/remu-type-system/blob/master/lib/rets_parser.mly *)

typ:
  | tapp=typeapp {tapp}
  | arg=typlit ARROW ret=typ { Arrow(arg, ret) }
  | LB elts=separated_list(COMMA, typ) RB {Tuple elts}
  | FORALL LBB ns=separated_list(COMMA, ID) RBB ty=typ {Forall(ns, ty)}
  | LBB fs=rowtyp RBB {Record(fs)}
  | LBB witness=typ RBB IMPLY bounded=typ {Implicit(witness, bounded)}
  ;

typeapp:
  | f=typeapp arg=typlit {App(f, arg)}
  | a=typlit {a}
  ;

typlit:
  | tid=STRING {mk_nom tid}
  | QUOTE a=ID {Fresh a}
  | LP nest=typ RP {nest}
  ;

rowtyp: fs=separated_list(COMMA, rowfield) tl=option(rowtail) {
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