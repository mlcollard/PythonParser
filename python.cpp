/*
    identity.cpp

    Identity copy
*/

#include <iostream>
#include <fstream>
#include "PythonLexer.h"
#include "PythonParser.h"

int main(int argc, char* argv[]) {

    // setup input
    std::ifstream file(argv[1]);
    antlr4::ANTLRInputStream input(file);

    // setup lexer
    PythonLexer lexer(&input);
    antlr4::CommonTokenStream tokens(&lexer);

    PythonParser parser(&tokens);
    parser.setTrace(true);
    try {
        antlr4::tree::ParseTree* tree = parser.main();
        // std::cout << tree->toStringTree() << std::endl;
        return 0;
    } catch (std::invalid_argument &e) {
        std::cout << e.what() << std::endl;
        return 1;
    }

    return 0;
}
