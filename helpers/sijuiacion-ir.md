# Sijuiacion IR

The link of the implementation is [here](https://github.com/RemuLang/sijuiacion-lang).

## Introduction

I named this IR `sijuiacion`, for using the a fuller instruction set of Python Virtual Machine. It's convenient for at least education purpose, due to following reasons:

- `sijuiacion` provides the facilities to make a very good runtime error report, which helps a lot to debugging and avoids introducing unrelated complexities.

- Instructions of Python Virtual Machine is small, and `sijuiacion` extracts a concise core language from it, resulting into smaller set of instuctions due to better abstractions.
- Python Virtual Machine provides GC, thus we don't have to care about GC stuffs.

The grammar of this IR is simple, within 40 lines and the code is really sparse:

```antlr
START : <BOF> 'runtime' <ID> [Attrs] Instrs <EOF> ;

Instrs : [Instrs] Instr;

Instr : 'load'   <ID>
      | 'store'  <ID>
      | 'deref'  <ID>
      | 'refset' <ID>
      | 'const'  <PY>
      | 'pop'
      | 'rot'    <INT>
      | 'dup'    <INT>
      | 'goto'   <ID>
      | 'goto-if' <ID>
      | 'goto-if-not' <ID>
      | 'label'       <ID>
      | 'call'        <INT>
      | 'print'
      | 'list'        <INT>
      | 'tuple'       <INT>
      | 'return'
      | 'line'        <INT>
      | 'defun' [Attrs] '{' Instrs '}'
     ;

Attrs : [Attrs] Attr;

Attr : 'document' <STRING>
     | 'filename' <STRING>
     | 'free' IDs
     | 'name' <STRING>
     | 'args' IDs
     | 'firstlineno' <INT>
    ;

IDs : '[' [IDList] ']';
IDList : [IDList] <ID>;
```

##  Installation

```
pip install -U moshmosh-base --no-compile
```
##  Examples

```
runtime operator
firstlineno 5
defun
  args [x]
  {
  const #add#
  const #1#
  load x
  call 2
  return
}
const #8#
call 1
return
```
produces
```
9
```
