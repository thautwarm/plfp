
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | STRING of (
# 26 "lib/parser.mly"
       (string)
# 11 "lib/parser.ml"
  )
    | SEMICON
    | RP
    | RBB
    | RB
    | QUOTE
    | OR
    | LP
    | LET
    | LBB
    | LB
    | INT of (
# 24 "lib/parser.mly"
       (string)
# 26 "lib/parser.ml"
  )
    | IN
    | IMPLY
    | ID of (
# 27 "lib/parser.mly"
       (string)
# 33 "lib/parser.ml"
  )
    | FORALL
    | FN
    | FLOAT of (
# 25 "lib/parser.mly"
       (string)
# 40 "lib/parser.ml"
  )
    | EOF
    | COMMA
    | COLON
    | ASSIGN
    | ARROW
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState78
  | MenhirState69
  | MenhirState67
  | MenhirState65
  | MenhirState62
  | MenhirState58
  | MenhirState53
  | MenhirState46
  | MenhirState43
  | MenhirState37
  | MenhirState33
  | MenhirState27
  | MenhirState22
  | MenhirState21
  | MenhirState19
  | MenhirState15
  | MenhirState13
  | MenhirState11
  | MenhirState10
  | MenhirState9
  | MenhirState5
  | MenhirState2
  | MenhirState0

# 1 "lib/parser.mly"
  
open Final
open Final.SYMSelf
open Remu_ts.Infer

# 93 "lib/parser.ml"

let rec _menhir_goto_separated_nonempty_list_COMMA_rowfield_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_rowfield_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv317) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_rowfield_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv315) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_rowfield_) : 'tv_separated_nonempty_list_COMMA_rowfield_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_rowfield__ = 
# 144 "<standard.mly>"
    ( x )
# 110 "lib/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_rowfield__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv316)) : 'freshtv318)
    | MenhirState43 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv321 * _menhir_state * 'tv_rowfield)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_rowfield_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv319 * _menhir_state * 'tv_rowfield)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_rowfield_) : 'tv_separated_nonempty_list_COMMA_rowfield_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_rowfield)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_rowfield_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 127 "lib/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_rowfield_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv320)) : 'freshtv322)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_typ_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_typ_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv309 * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_typ_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv307 * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_typ_) : 'tv_separated_nonempty_list_COMMA_typ_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_typ)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_typ_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 150 "lib/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_typ_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv308)) : 'freshtv310)
    | MenhirState11 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv313) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_typ_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv311) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_typ_) : 'tv_separated_nonempty_list_COMMA_typ_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_typ__ = 
# 144 "<standard.mly>"
    ( x )
# 165 "lib/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_typ__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv312)) : 'freshtv314)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_SEMICON_expr_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_SEMICON_expr_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv301) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_SEMICON_expr_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv299) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_SEMICON_expr_) : 'tv_separated_nonempty_list_SEMICON_expr_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_SEMICON_expr__ = 
# 144 "<standard.mly>"
    ( x )
# 186 "lib/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_SEMICON_expr__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv300)) : 'freshtv302)
    | MenhirState78 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv305 * _menhir_state * 'tv_expr)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_SEMICON_expr_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv303 * _menhir_state * 'tv_expr)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_SEMICON_expr_) : 'tv_separated_nonempty_list_SEMICON_expr_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_expr)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_SEMICON_expr_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 203 "lib/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_SEMICON_expr_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv304)) : 'freshtv306)
    | _ ->
        _menhir_fail ()

and _menhir_goto_typeapp : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_typeapp -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv297 * _menhir_state * 'tv_typeapp) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LP ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | QUOTE ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
    | ASSIGN | COMMA | OR | RB | RBB | RP ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv295 * _menhir_state * 'tv_typeapp) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (tapp : 'tv_typeapp)) = _menhir_stack in
        let _v : 'tv_typ = 
# 62 "lib/parser.mly"
                 (tapp)
# 230 "lib/parser.ml"
         in
        _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv296)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState22) : 'freshtv298)

and _menhir_goto_option_rowtail_ : _menhir_env -> 'ttv_tail -> 'tv_option_rowtail_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv293 * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_rowfield__) = Obj.magic _menhir_stack in
    let (_v : 'tv_option_rowtail_) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv291 * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_rowfield__) = Obj.magic _menhir_stack in
    let ((tl : 'tv_option_rowtail_) : 'tv_option_rowtail_) = _v in
    ((let (_menhir_stack, _menhir_s, (xs : 'tv_loption_separated_nonempty_list_COMMA_rowfield__)) = _menhir_stack in
    let _v : 'tv_rowtyp = let fs = 
# 232 "<standard.mly>"
    ( xs )
# 250 "lib/parser.ml"
     in
    
# 81 "lib/parser.mly"
                                                              (
      begin match tl with
      | Some tl -> RowPoly tl
      | _ -> RowMono
      end |> record fs
  )
# 260 "lib/parser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv289) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_rowtyp) = _v in
    ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv287 * _menhir_state) * _menhir_state * 'tv_rowtyp) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RBB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv283 * _menhir_state) * _menhir_state * 'tv_rowtyp) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv281 * _menhir_state) * _menhir_state * 'tv_rowtyp) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, (fs : 'tv_rowtyp)) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : 'tv_typ = 
# 66 "lib/parser.mly"
                      (Record(fs))
# 284 "lib/parser.ml"
         in
        _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv282)) : 'freshtv284)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv285 * _menhir_state) * _menhir_state * 'tv_rowtyp) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv286)) : 'freshtv288)) : 'freshtv290)) : 'freshtv292)) : 'freshtv294)

and _menhir_goto_typ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_typ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv215 * _menhir_state * 'tv_typlit)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv213 * _menhir_state * 'tv_typlit)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (arg : 'tv_typlit)), _, (ret : 'tv_typ)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_typ = 
# 63 "lib/parser.mly"
                             ( Arrow(arg, ret) )
# 309 "lib/parser.ml"
         in
        _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv214)) : 'freshtv216)
    | MenhirState19 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv219 * _menhir_state)) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_ID__)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv217 * _menhir_state)) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_ID__)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _, (xs : 'tv_loption_separated_nonempty_list_COMMA_ID__)), _, (ty : 'tv_typ)) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_typ = let ns = 
# 232 "<standard.mly>"
    ( xs )
# 324 "lib/parser.ml"
         in
        
# 65 "lib/parser.mly"
                                                       (Forall(ns, ty))
# 329 "lib/parser.ml"
         in
        _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv218)) : 'freshtv220)
    | MenhirState27 | MenhirState11 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv227 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv221 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FORALL ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState27
            | LB ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState27
            | LBB ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState27
            | LP ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState27
            | QUOTE ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState27
            | STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27) : 'freshtv222)
        | RB ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv223 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_typ)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_COMMA_typ_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 367 "lib/parser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_typ_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv224)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv225 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv226)) : 'freshtv228)
    | MenhirState33 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv241 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 382 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv239 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 388 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (k : (
# 27 "lib/parser.mly"
       (string)
# 393 "lib/parser.ml"
        ))), _, (v : 'tv_typ)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_rowfield = 
# 91 "lib/parser.mly"
                     ((k, v))
# 399 "lib/parser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv237) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_rowfield) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv235 * _menhir_state * 'tv_rowfield) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv229 * _menhir_state * 'tv_rowfield) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ID _v ->
                _menhir_run32 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState43) : 'freshtv230)
        | OR | RBB ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv231 * _menhir_state * 'tv_rowfield) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_rowfield)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_COMMA_rowfield_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 430 "lib/parser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_rowfield_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv232)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv233 * _menhir_state * 'tv_rowfield) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv234)) : 'freshtv236)) : 'freshtv238)) : 'freshtv240)) : 'freshtv242)
    | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv251 * _menhir_state) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBB ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv247 * _menhir_state) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IMPLY ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv243 * _menhir_state) * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | FORALL ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                | LB ->
                    _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                | LBB ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                | LP ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                | QUOTE ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                | STRING _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState37) : 'freshtv244)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv245 * _menhir_state) * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv246)) : 'freshtv248)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv249 * _menhir_state) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv250)) : 'freshtv252)
    | MenhirState37 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv255 * _menhir_state) * _menhir_state * 'tv_typ))) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv253 * _menhir_state) * _menhir_state * 'tv_typ))) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _, (witness : 'tv_typ)), _, (bounded : 'tv_typ)) = _menhir_stack in
        let _4 = () in
        let _3 = () in
        let _1 = () in
        let _v : 'tv_typ = 
# 67 "lib/parser.mly"
                                          (Implicit(witness, bounded))
# 500 "lib/parser.ml"
         in
        _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv254)) : 'freshtv256)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv265) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv263) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _, (b : 'tv_typ)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_rowtail = 
# 88 "lib/parser.mly"
                  (b)
# 513 "lib/parser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv261) = _menhir_stack in
        let (_v : 'tv_rowtail) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv259) = Obj.magic _menhir_stack in
        let (_v : 'tv_rowtail) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv257) = Obj.magic _menhir_stack in
        let ((x : 'tv_rowtail) : 'tv_rowtail) = _v in
        ((let _v : 'tv_option_rowtail_ = 
# 116 "<standard.mly>"
    ( Some x )
# 527 "lib/parser.ml"
         in
        _menhir_goto_option_rowtail_ _menhir_env _menhir_stack _v) : 'freshtv258)) : 'freshtv260)) : 'freshtv262)) : 'freshtv264)) : 'freshtv266)
    | MenhirState9 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv273 * _menhir_state) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RP ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv269 * _menhir_state) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv267 * _menhir_state) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (nest : 'tv_typ)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_typlit = 
# 78 "lib/parser.mly"
                   (nest)
# 548 "lib/parser.ml"
             in
            _menhir_goto_typlit _menhir_env _menhir_stack _menhir_s _v) : 'freshtv268)) : 'freshtv270)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv271 * _menhir_state) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv272)) : 'freshtv274)
    | MenhirState5 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv279 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 563 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ASSIGN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv275 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 573 "lib/parser.ml"
            ))) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FLOAT _v ->
                _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v
            | FN ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState53
            | ID _v ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v
            | INT _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v
            | LET ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState53
            | LP ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState53
            | STRING _v ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState53) : 'freshtv276)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv277 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 603 "lib/parser.ml"
            ))) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv278)) : 'freshtv280)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_ID_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_ID_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState15 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv207 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 618 "lib/parser.ml"
        ))) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_ID_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv205 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 626 "lib/parser.ml"
        ))) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_ID_) : 'tv_separated_nonempty_list_COMMA_ID_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : (
# 27 "lib/parser.mly"
       (string)
# 633 "lib/parser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_ID_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 639 "lib/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_ID_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv206)) : 'freshtv208)
    | MenhirState13 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv211) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_ID_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv209) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_ID_) : 'tv_separated_nonempty_list_COMMA_ID_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_ID__ = 
# 144 "<standard.mly>"
    ( x )
# 654 "lib/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_ID__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv210)) : 'freshtv212)
    | _ ->
        _menhir_fail ()

and _menhir_goto_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_expr -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState58 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv167 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 669 "lib/parser.ml"
        ))) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv165 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 675 "lib/parser.ml"
        ))) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), (n : (
# 27 "lib/parser.mly"
       (string)
# 680 "lib/parser.ml"
        ))), _, (body : 'tv_expr)) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : 'tv_expr = 
# 41 "lib/parser.mly"
                            (lam n body)
# 687 "lib/parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v) : 'freshtv166)) : 'freshtv168)
    | MenhirState53 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv173 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 695 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv169 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 705 "lib/parser.ml"
            ))) * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FLOAT _v ->
                _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
            | FN ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | ID _v ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
            | INT _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
            | LET ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | LP ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | STRING _v ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState65) : 'freshtv170)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv171 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 735 "lib/parser.ml"
            ))) * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv172)) : 'freshtv174)
    | MenhirState65 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv177 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 744 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_expr)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv175 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 750 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_expr)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((let (((((_menhir_stack, _menhir_s), (n : (
# 27 "lib/parser.mly"
       (string)
# 755 "lib/parser.ml"
        ))), _, (t : 'tv_typ)), _, (bound : 'tv_expr)), _, (body : 'tv_expr)) = _menhir_stack in
        let _7 = () in
        let _5 = () in
        let _3 = () in
        let _1 = () in
        let _v : 'tv_expr = 
# 40 "lib/parser.mly"
                                                        (letl n (Some t) bound body)
# 764 "lib/parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v) : 'freshtv176)) : 'freshtv178)
    | MenhirState67 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv183 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 772 "lib/parser.ml"
        ))) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv179 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 782 "lib/parser.ml"
            ))) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FLOAT _v ->
                _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
            | FN ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | ID _v ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
            | INT _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
            | LET ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | LP ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | STRING _v ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState69) : 'freshtv180)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv181 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 812 "lib/parser.ml"
            ))) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv182)) : 'freshtv184)
    | MenhirState69 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv187 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 821 "lib/parser.ml"
        ))) * _menhir_state * 'tv_expr)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv185 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 827 "lib/parser.ml"
        ))) * _menhir_state * 'tv_expr)) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((let ((((_menhir_stack, _menhir_s), (n : (
# 27 "lib/parser.mly"
       (string)
# 832 "lib/parser.ml"
        ))), _, (bound : 'tv_expr)), _, (body : 'tv_expr)) = _menhir_stack in
        let _5 = () in
        let _3 = () in
        let _1 = () in
        let _v : 'tv_expr = 
# 39 "lib/parser.mly"
                                            (letl n None bound body)
# 840 "lib/parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v) : 'freshtv186)) : 'freshtv188)
    | MenhirState2 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv195 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RP ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv191 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv189 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (nest : 'tv_expr)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_atom = 
# 55 "lib/parser.mly"
                    (nest)
# 861 "lib/parser.ml"
             in
            _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv190)) : 'freshtv192)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv193 * _menhir_state) * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv194)) : 'freshtv196)
    | MenhirState78 | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv203 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv197 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FLOAT _v ->
                _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
            | FN ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | ID _v ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
            | INT _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
            | LET ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | LP ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | STRING _v ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState78) : 'freshtv198)
        | EOF ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv199 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_expr)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_SEMICON_expr_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 908 "lib/parser.ml"
             in
            _menhir_goto_separated_nonempty_list_SEMICON_expr_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv200)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv201 * _menhir_state * 'tv_expr) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv202)) : 'freshtv204)
    | _ ->
        _menhir_fail ()

and _menhir_goto_typlit : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_typlit -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState5 | MenhirState9 | MenhirState46 | MenhirState37 | MenhirState10 | MenhirState33 | MenhirState27 | MenhirState11 | MenhirState21 | MenhirState19 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv159 * _menhir_state * 'tv_typlit) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ARROW ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv153 * _menhir_state * 'tv_typlit) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FORALL ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState21
            | LB ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState21
            | LBB ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState21
            | LP ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState21
            | QUOTE ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState21
            | STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState21) : 'freshtv154)
        | ASSIGN | COMMA | LP | OR | QUOTE | RB | RBB | RP | STRING _ ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv155 * _menhir_state * 'tv_typlit) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (a : 'tv_typlit)) = _menhir_stack in
            let _v : 'tv_typeapp = 
# 72 "lib/parser.mly"
             (a)
# 960 "lib/parser.ml"
             in
            _menhir_goto_typeapp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv156)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv157 * _menhir_state * 'tv_typlit) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv158)) : 'freshtv160)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv163 * _menhir_state * 'tv_typeapp) * _menhir_state * 'tv_typlit) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv161 * _menhir_state * 'tv_typeapp) * _menhir_state * 'tv_typlit) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (f : 'tv_typeapp)), _, (arg : 'tv_typlit)) = _menhir_stack in
        let _v : 'tv_typeapp = 
# 71 "lib/parser.mly"
                         (App(f, arg))
# 979 "lib/parser.ml"
         in
        _menhir_goto_typeapp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv162)) : 'freshtv164)
    | _ ->
        _menhir_fail ()

and _menhir_goto_loption_separated_nonempty_list_COMMA_rowfield__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_rowfield__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv151 * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_rowfield__) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | OR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv145) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | FORALL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState46
        | LB ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState46
        | LBB ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState46
        | LP ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState46
        | QUOTE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState46
        | STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState46 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState46) : 'freshtv146)
    | RBB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv147) = Obj.magic _menhir_stack in
        ((let _v : 'tv_option_rowtail_ = 
# 114 "<standard.mly>"
    ( None )
# 1021 "lib/parser.ml"
         in
        _menhir_goto_option_rowtail_ _menhir_env _menhir_stack _v) : 'freshtv148)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv149 * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_rowfield__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv150)) : 'freshtv152)

and _menhir_run32 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 27 "lib/parser.mly"
       (string)
# 1035 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COLON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv141 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 1047 "lib/parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | FORALL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | LB ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | LBB ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | LP ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | QUOTE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState33) : 'freshtv142)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv143 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 1075 "lib/parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv144)

and _menhir_goto_loption_separated_nonempty_list_COMMA_typ__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_typ__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv139 * _menhir_state) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_typ__) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv135 * _menhir_state) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_typ__) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv133 * _menhir_state) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_typ__) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, (xs : 'tv_loption_separated_nonempty_list_COMMA_typ__)) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : 'tv_typ = let elts = 
# 232 "<standard.mly>"
    ( xs )
# 1100 "lib/parser.ml"
         in
        
# 64 "lib/parser.mly"
                                          (Tuple elts)
# 1105 "lib/parser.ml"
         in
        _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv134)) : 'freshtv136)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv137 * _menhir_state) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_typ__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv138)) : 'freshtv140)

and _menhir_goto_loption_separated_nonempty_list_COMMA_ID__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_ID__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv131 * _menhir_state)) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_ID__) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RBB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv127 * _menhir_state)) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_ID__) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | FORALL ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState19
        | LB ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState19
        | LBB ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState19
        | LP ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState19
        | QUOTE ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState19
        | STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState19) : 'freshtv128)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv129 * _menhir_state)) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_ID__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv130)) : 'freshtv132)

and _menhir_run14 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 27 "lib/parser.mly"
       (string)
# 1157 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv121 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 1169 "lib/parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ID _v ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState15 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState15) : 'freshtv122)
    | RBB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv123 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 1185 "lib/parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (x : (
# 27 "lib/parser.mly"
       (string)
# 1190 "lib/parser.ml"
        ))) = _menhir_stack in
        let _v : 'tv_separated_nonempty_list_COMMA_ID_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 1195 "lib/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_ID_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv124)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv125 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 1205 "lib/parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv126)

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_app : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv119 * _menhir_state * 'tv_app) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FLOAT _v ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
    | ID _v ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
    | INT _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
    | LP ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState62
    | STRING _v ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
    | EOF | IN | RP | SEMICON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv117 * _menhir_state * 'tv_app) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (a : 'tv_app)) = _menhir_stack in
        let _v : 'tv_expr = 
# 42 "lib/parser.mly"
          (a)
# 1240 "lib/parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v) : 'freshtv118)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState62) : 'freshtv120)

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 26 "lib/parser.mly"
       (string)
# 1251 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv115) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((tid : (
# 26 "lib/parser.mly"
       (string)
# 1261 "lib/parser.ml"
    )) : (
# 26 "lib/parser.mly"
       (string)
# 1265 "lib/parser.ml"
    )) = _v in
    ((let _v : 'tv_typlit = 
# 76 "lib/parser.mly"
               (mk_nom tid)
# 1270 "lib/parser.ml"
     in
    _menhir_goto_typlit _menhir_env _menhir_stack _menhir_s _v) : 'freshtv116)

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv111 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 27 "lib/parser.mly"
       (string)
# 1286 "lib/parser.ml"
        )) = _v in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv109 * _menhir_state) = Obj.magic _menhir_stack in
        let ((a : (
# 27 "lib/parser.mly"
       (string)
# 1294 "lib/parser.ml"
        )) : (
# 27 "lib/parser.mly"
       (string)
# 1298 "lib/parser.ml"
        )) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_typlit = 
# 77 "lib/parser.mly"
               (Fresh a)
# 1305 "lib/parser.ml"
         in
        _menhir_goto_typlit _menhir_env _menhir_stack _menhir_s _v) : 'freshtv110)) : 'freshtv112)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv113 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv114)

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FORALL ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | LB ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | LBB ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | LP ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | QUOTE ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState9 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState9

and _menhir_run10 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FORALL ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState10
    | ID _v ->
        _menhir_run32 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _v
    | LB ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState10
    | LBB ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState10
    | LP ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState10
    | QUOTE ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState10
    | STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _v
    | OR | RBB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv107) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState10 in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_rowfield__ = 
# 142 "<standard.mly>"
    ( [] )
# 1366 "lib/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_rowfield__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv108)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState10

and _menhir_run11 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FORALL ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | LB ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | LBB ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | LP ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | QUOTE ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
    | RB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv105) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState11 in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_typ__ = 
# 142 "<standard.mly>"
    ( [] )
# 1399 "lib/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_typ__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv106)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState11

and _menhir_run12 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LBB ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv101 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ID _v ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
        | RBB ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv99) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState13 in
            ((let _v : 'tv_loption_separated_nonempty_list_COMMA_ID__ = 
# 142 "<standard.mly>"
    ( [] )
# 1428 "lib/parser.ml"
             in
            _menhir_goto_loption_separated_nonempty_list_COMMA_ID__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv100)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13) : 'freshtv102)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv103 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv104)

and _menhir_goto_atom : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_atom -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState0 | MenhirState78 | MenhirState2 | MenhirState67 | MenhirState69 | MenhirState53 | MenhirState65 | MenhirState58 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv93) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_atom) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv91) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((a : 'tv_atom) : 'tv_atom) = _v in
        ((let _v : 'tv_app = 
# 47 "lib/parser.mly"
           (a)
# 1458 "lib/parser.ml"
         in
        _menhir_goto_app _menhir_env _menhir_stack _menhir_s _v) : 'freshtv92)) : 'freshtv94)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv97 * _menhir_state * 'tv_app) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_atom) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv95 * _menhir_state * 'tv_app) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((a : 'tv_atom) : 'tv_atom) = _v in
        ((let (_menhir_stack, _menhir_s, (f : 'tv_app)) = _menhir_stack in
        let _v : 'tv_app = 
# 46 "lib/parser.mly"
                 (app f a)
# 1474 "lib/parser.ml"
         in
        _menhir_goto_app _menhir_env _menhir_stack _menhir_s _v) : 'freshtv96)) : 'freshtv98)
    | _ ->
        _menhir_fail ()

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState78 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv45 * _menhir_state * 'tv_expr)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv46)
    | MenhirState69 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv47 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1493 "lib/parser.ml"
        ))) * _menhir_state * 'tv_expr)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv48)
    | MenhirState67 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv49 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1502 "lib/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv50)
    | MenhirState65 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv51 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1511 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_expr)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv52)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv53 * _menhir_state * 'tv_app) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv54)
    | MenhirState58 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv55 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1525 "lib/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv56)
    | MenhirState53 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv57 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1534 "lib/parser.ml"
        ))) * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv58)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv59) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv60)
    | MenhirState43 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv61 * _menhir_state * 'tv_rowfield)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv62)
    | MenhirState37 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv63 * _menhir_state) * _menhir_state * 'tv_typ))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv64)
    | MenhirState33 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv65 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 1557 "lib/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv66)
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv67 * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv68)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv69 * _menhir_state * 'tv_typeapp) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv70)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv71 * _menhir_state * 'tv_typlit)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv72)
    | MenhirState19 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv73 * _menhir_state)) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_ID__)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv74)
    | MenhirState15 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv75 * _menhir_state * (
# 27 "lib/parser.mly"
       (string)
# 1586 "lib/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv76)
    | MenhirState13 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv77 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv78)
    | MenhirState11 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv79 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv80)
    | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv81 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv82)
    | MenhirState9 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv83 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv84)
    | MenhirState5 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv85 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1615 "lib/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv86)
    | MenhirState2 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv87 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv88)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv89) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv90)

and _menhir_goto_loption_separated_nonempty_list_SEMICON_expr__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_SEMICON_expr__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv43 * _menhir_state * 'tv_loption_separated_nonempty_list_SEMICON_expr__) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EOF ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv39 * _menhir_state * 'tv_loption_separated_nonempty_list_SEMICON_expr__) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv37 * _menhir_state * 'tv_loption_separated_nonempty_list_SEMICON_expr__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (xs : 'tv_loption_separated_nonempty_list_SEMICON_expr__)) = _menhir_stack in
        let _2 = () in
        let _v : (
# 31 "lib/parser.mly"
       (Final.SYMSelf.r list)
# 1647 "lib/parser.ml"
        ) = let stmts = 
# 232 "<standard.mly>"
    ( xs )
# 1651 "lib/parser.ml"
         in
        
# 36 "lib/parser.mly"
                                              (stmts)
# 1656 "lib/parser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv35) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : (
# 31 "lib/parser.mly"
       (Final.SYMSelf.r list)
# 1664 "lib/parser.ml"
        )) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv33) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : (
# 31 "lib/parser.mly"
       (Final.SYMSelf.r list)
# 1672 "lib/parser.ml"
        )) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv31) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : (
# 31 "lib/parser.mly"
       (Final.SYMSelf.r list)
# 1680 "lib/parser.ml"
        )) : (
# 31 "lib/parser.mly"
       (Final.SYMSelf.r list)
# 1684 "lib/parser.ml"
        )) = _v in
        (Obj.magic _1 : 'freshtv32)) : 'freshtv34)) : 'freshtv36)) : 'freshtv38)) : 'freshtv40)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv41 * _menhir_state * 'tv_loption_separated_nonempty_list_SEMICON_expr__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv42)) : 'freshtv44)

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 26 "lib/parser.mly"
       (string)
# 1698 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv29) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((a : (
# 26 "lib/parser.mly"
       (string)
# 1708 "lib/parser.ml"
    )) : (
# 26 "lib/parser.mly"
       (string)
# 1712 "lib/parser.ml"
    )) = _v in
    ((let _v : 'tv_atom = 
# 53 "lib/parser.mly"
             (lit StringT a)
# 1717 "lib/parser.ml"
     in
    _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv30)

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FLOAT _v ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | FN ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | ID _v ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | INT _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | LET ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | LP ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | STRING _v ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState2

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv25 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 27 "lib/parser.mly"
       (string)
# 1758 "lib/parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ASSIGN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv19 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1769 "lib/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FLOAT _v ->
                _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v
            | FN ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState67
            | ID _v ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v
            | INT _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v
            | LET ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState67
            | LP ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState67
            | STRING _v ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState67) : 'freshtv20)
        | COLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv21 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1797 "lib/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FORALL ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | LB ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | LBB ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | LP ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | QUOTE ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState5) : 'freshtv22)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv23 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1825 "lib/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv24)) : 'freshtv26)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv27 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv28)

and _menhir_run54 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 24 "lib/parser.mly"
       (string)
# 1840 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv17) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((a : (
# 24 "lib/parser.mly"
       (string)
# 1850 "lib/parser.ml"
    )) : (
# 24 "lib/parser.mly"
       (string)
# 1854 "lib/parser.ml"
    )) = _v in
    ((let _v : 'tv_atom = 
# 51 "lib/parser.mly"
           (lit IntT a)
# 1859 "lib/parser.ml"
     in
    _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv18)

and _menhir_run55 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 27 "lib/parser.mly"
       (string)
# 1866 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv15) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((a : (
# 27 "lib/parser.mly"
       (string)
# 1876 "lib/parser.ml"
    )) : (
# 27 "lib/parser.mly"
       (string)
# 1880 "lib/parser.ml"
    )) = _v in
    ((let _v : 'tv_atom = 
# 54 "lib/parser.mly"
         (var a)
# 1885 "lib/parser.ml"
     in
    _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv16)

and _menhir_run56 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv11 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 27 "lib/parser.mly"
       (string)
# 1901 "lib/parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ARROW ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv7 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1912 "lib/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | FLOAT _v ->
                _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
            | FN ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | ID _v ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
            | INT _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
            | LET ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | LP ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | STRING _v ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState58) : 'freshtv8)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv9 * _menhir_state) * (
# 27 "lib/parser.mly"
       (string)
# 1942 "lib/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv10)) : 'freshtv12)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv13 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv14)

and _menhir_run59 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 25 "lib/parser.mly"
       (string)
# 1957 "lib/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv5) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((a : (
# 25 "lib/parser.mly"
       (string)
# 1967 "lib/parser.ml"
    )) : (
# 25 "lib/parser.mly"
       (string)
# 1971 "lib/parser.ml"
    )) = _v in
    ((let _v : 'tv_atom = 
# 52 "lib/parser.mly"
            (lit FloatT a)
# 1976 "lib/parser.ml"
     in
    _menhir_goto_atom _menhir_env _menhir_stack _menhir_s _v) : 'freshtv6)

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and prog : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 31 "lib/parser.mly"
       (Final.SYMSelf.r list)
# 1995 "lib/parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env =
      let (lexer : Lexing.lexbuf -> token) = lexer in
      let (lexbuf : Lexing.lexbuf) = lexbuf in
      ((let _tok = Obj.magic () in
      {
        _menhir_lexer = lexer;
        _menhir_lexbuf = lexbuf;
        _menhir_token = _tok;
        _menhir_error = false;
      }) : _menhir_env)
    in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv3) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FLOAT _v ->
        _menhir_run59 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | FN ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | ID _v ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | INT _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | LET ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LP ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | STRING _v ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | EOF ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState0 in
        ((let _v : 'tv_loption_separated_nonempty_list_SEMICON_expr__ = 
# 142 "<standard.mly>"
    ( [] )
# 2035 "lib/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_SEMICON_expr__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv2)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv4))

# 269 "<standard.mly>"
  

# 2046 "lib/parser.ml"
