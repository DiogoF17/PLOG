/* ====================================
                GAME
   ==================================== */ 

initialBoard([
       [' '],
       [' ', ' '],
       ['Z', ' ', 'Z'],
       ['Z', ' ', ' ', 'Z'],
       [' ', ' ', 'Z', ' ', ' '],
       [' ', ' ', 'Z', 'Z', ' ', ' '],
       ['O', ' ', ' ', 'Z', ' ', ' ', 'X'],
       ['O', 'O', ' ', ' ', ' ', ' ', 'X', 'X'],
       ['O', 'O', 'O', ' ', ' ', ' ', 'X', 'X', 'X'],
       ['O', 'O', 'O', 'O', ' ', ' ', 'X', 'X', 'X', 'X']]).

printPontuations(ElementsO, ElementsX, ElementsZ) :-
    format("------------------------------\n", []),
    format("| Number Elements Eliminated |\n", []),
    format("------------------------------\n", []),
    format("| O: ~p                       |\n", [ElementsO]),
    format("| X: ~p                       |\n", [ElementsX]),
    format("| Z: ~p                       |\n", [ElementsZ]),
    format("------------------------------\n\n", []).

printBoard(Board, Message) :- 
    format('\n\n========================================\n\t ~s \n========================================', [Message]),
    printRow1(Board).

printRow1([Row | Rest]) :-
    format("\n\n                        O#   #X                                   |   Tabuleiro Auxiliar que indica a posicao dos              O#   #X\n", []),
    format("                      O# | ~p | #X                                 |      elementos atraves de (Row, Column)               O# | (1, 1) | #X\n", Row),
    printRow2(Rest).

printRow2([Row | Rest]) :-
    format("                    O# | ~p | ~p | #X                               |                                                   O# | (2, 1) | (2, 2) | #X\n", Row),
    printRow3(Rest).

printRow3([Row | Rest]) :-
    format("                  O# | ~p | ~p | ~p | #X                             |                                               O# | (3, 1) | (3, 2) | (3, 3) | #X\n", Row),
    printRow4(Rest).

printRow4([Row | Rest]) :-
    format("                O# | ~p | ~p | ~p | ~p | #X                           |                                           O# | (4, 1) | (4, 2) | (4, 3) | (4, 4) | #X\n", Row),
    printRow5(Rest).

printRow5([Row | Rest]) :-
    format("              O# | ~p | ~p | ~p | ~p | ~p | #X                         |                                       O# | (5, 1) | (5, 2) | (5, 3) | (5, 4) | (5, 5) | #X\n", Row),
    printRow6(Rest).

printRow6([Row | Rest]) :-
    format("            O# | ~p | ~p | ~p | ~p | ~p | ~p | #X                       |                                   O# | (6, 1) | (6, 2) | (6, 3) | (6, 4) | (6, 5) | (6, 6) | #X\n", Row),
    printRow7(Rest).

printRow7([Row | Rest]) :-
    format("          O# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #X                     |                                O# | (7, 1) | (7, 2) | (7, 3) | (7, 4) | (7, 5) | (7, 6) | (7, 7) | #X\n", Row),
    printRow8(Rest).

printRow8([Row | Rest]) :-
    format("        O# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #X                   |                            O# | (8, 1) | (8, 2) | (8, 3) | (8, 4) | (8, 5) | (8, 6) | (8, 7) | (8, 8) | #X\n", Row),
    printRow9(Rest).

printRow9([Row | Rest]) :-
    format("      O# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #X                 |                        O# | (9, 1) | (9, 2) | (9, 3) | (9, 4) | (9, 5) | (9, 6) | (9, 7) | (9, 8) | (9, 9) | #X\n", Row),
    printRow10(Rest).

printRow10([Row | _Rest]) :-
    format("    O# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #X               |               O# | (10, 1) | (10, 2) | (10, 3) | (10, 4) | (10, 5) | (10, 6) | (10, 7) | (10, 8) | (10, 9) | (10, 10) | #X\n", Row),
    format("       #########################################                                     ######################################################################################################\n", []),
    format("           Z   Z   Z   Z   Z   Z   Z   Z   Z   Z                                          Z         Z         Z         Z         Z         Z         Z         Z         Z         Z\n\n", []).

readNextMove :-
    format('----------------------------------------\n', []),
    format("\tWhat's your next move?\n", []),
    format('----------------------------------------\n\n', []),
    format('Next Row: ', []), read(Row),
    format('Next Column: ', []), read(Column),
    printPlayerMove(Column, Row).

printPlayerMove(Column, Row) :-
    format('\nColumn: ~p | Row: ~p', [Column, Row]).

/* ====================================
                MENU
   ==================================== */ 

printMenu :- 
    format('\n\n========================================\n', []),
    format('\tMAIN MENU\n', []),
    format('========================================\n', []),
    format('\n\n1) Jogar 1 vs 1;\n', []),
    format('2) Jogar 1 vs PC;\n', []),
    format('3) Jogar PC vs PC;\n', []),
    format('\nInsira a sua opcao: ', []), read(Option),
    verifyMainMenuOption(Option).

verifyMainMenuOption(Option) :-
    integer(Option), Option >= 1, Option =< 3,
    nextState(Option).

verifyMainMenuOption(_Option) :-
    format("\nOpcao Invalida! Tente novamente: ", []), read(Option1),
    verifyMainMenuOption(Option1).

nextState(Option) :-
    Option == 1,
    initialBoard(Board),
    printBoard(Board, "HUMANO VS HUMANO"),
    printPontuations(0, 0, 0),
    readNextMove.

nextState(Option) :-
    Option == 2,
    initialBoard(Board),
    printBoard(Board, "HUMANO VS PC"),
    printPontuations(0, 0, 0),
    readNextMove.

nextState(Option) :-
    Option == 3,
    initialBoard(Board),
    printBoard(Board, "PC VS PC"),
    printPontuations(0, 0, 0),
    readNextMove.



