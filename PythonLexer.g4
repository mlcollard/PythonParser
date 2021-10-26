lexer grammar PythonLexer;

options {
    language=Cpp;
}

import PythonLexerBase;

@lexer::postinclude {
    #include <stack>
    #include <string>
}

@lexer::members {

    bool freshNewLine = false;
    std::stack<int> indentStack;
}

tokens { BLOCK_START, BLOCK_END }

COLON : ':' ;

ENDDEF : 'enddef' ;

WS : ({ !freshNewLine }? (' ' | '\t' | ('\n' { /* freshNewLine = true; */}))+) -> skip  ;

INDENTATION : ({ freshNewLine }? (' ' | '\t' | EOF)+) {

    freshNewLine = false;

    if (indentStack.empty() || getText().size() > indentStack.top()) {
        // INDENT
        indentStack.push(getText().size());
        setType(BLOCK_START);
        setText("<block>" + getText());
    } else {

        std::string s = getText();
        while (!indentStack.empty() && getText().size() < indentStack.top()) {
            // DEDENT
            indentStack.pop();
            setType(BLOCK_END);
            s += "</block>";
        }
        setText(s);
    }
};
