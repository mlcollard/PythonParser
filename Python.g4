grammar Python;

options {
    language=Cpp;
    tokenVocab=PythonLexer;
}

main : (function | statement)+ ;

function : (ASYNC)? DEF name parameters colon 
    (statement)+
    enddef
    ;

expr : name OPERATORS (name | OPERATORS | NUMBER)+ ;

enddef : ENDDEF ;

statement : pass | expr ;

pass : PASS ;

colon : COLON ;

parameters :  LPAREN NAME RPAREN ;

name : NAME ;
