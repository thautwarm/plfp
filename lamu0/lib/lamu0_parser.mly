%{
open Lamu0_ast
open Lamu0_ast.SYMSelf
%}

%token LET
%token IN
%token FN
/* %token SEMICOLON */
%token LP
%token RP
%token ARROW
%token ASSIGN
%token <string>INT
%token <string>FLOAT
%token <string>STRING
%token <string>ID
%token SEMICON
%token EOF

%start <Lamu0_ast.sym list> prog

%%


prog: stmts=separated_list(SEMICON, expr) EOF {stmts};

expr:
    LET n=ID ASSIGN bound=expr IN body=expr {letl n bound body}
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