/* ====================================
                GAME
   ==================================== */ 

board([
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
    read_current,
    read_next.

read_current :-
    format('Curent Element Row: ', []), read(CurrentRow),
    format('Curent Element Column: ', []), read(CurrentColumn),
    valid_move_current(CurrentRow, CurrentColumn).

read_next :-
    format('\n----------------------------------------\n\n', []),
    format('Next Element Row: ', []), read(NextRow),
    format('Next Element Column: ', []), read(NextColumn),
    valid_move_next(NextRow, NextColumn).

valid_move_current(Row, Column) :-
    Row >= 1, Row =< 10, Column >= 1, Column =< Row,
    find_element(Row, Column, X), 
    X == 'O',
    format("\nValid Move!", []).

valid_move_current(Row, Column) :-
    format('\nInvalid Move!\nCurent Element Row: ', []), read(CurrentRow),
    format('Curent Element Column: ', []), read(CurrentColumn),
    valid_move_current(CurrentRow, CurrentColumn).


valid_move_next(Row, Column) :-
    Row >= 1, Row =< 10, Column >= 1, Column =< Row,
    find_element(Row, Column, X), 
    X == ' ',
    format('\nValid Move!', []).

valid_move_next(Row, Column) :-
    format('\nInvalid Move!\nNext Element Row: ', []), read(NextRow),
    format('Next Element Column: ', []), read(NextColumn),
    valid_move_next(NextRow, NextColumn).

printPlayerMove(CurrentRow, CurrentColumn, NextRow, NextColumn) :-
    format('\nRow: ~p -> ~p \nColumn: ~p -> ~p', [CurrentRow, NextRow, CurrentColumn, NextColumn]).

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
    board(Board),
    printBoard(Board, "HUMANO VS HUMANO"),
    printPontuations(0, 0, 0),
    readNextMove.

nextState(Option) :-
    Option == 2,
    board(Board),
    printBoard(Board, "HUMANO VS PC"),
    printPontuations(0, 0, 0),
    readNextMove.

nextState(Option) :-
    Option == 3,
    board(Board),
    printBoard(Board, "PC VS PC"),
    printPontuations(0, 0, 0),
    readNextMove.


/*=====================================*/

/*show_list([Row1 | []]) :-
    format("------------\n", []),
    show_row(Row1), 
    format("\n------------\n", []),
    format("Lista Vazia\n", []).

show_list([Row1 | Row2]) :-
    format("------------\n", []),
    show_row(Row1), 
    format("\n------------\n", []),
    show_list(Row2).

show_row([]).

show_row([H | T]) :-
    format(" ~p |", [H]),
    show_row(T).*/

/*==================*/

find_element(ElementRow, ElementColumn, Element) :-
    board(Board),
    show_list(Board, 1, 1, ElementRow, ElementColumn, Element).

show_list([_Row1 | Row2], IndexRow, IndexColumn, ElementRow, ElementColumn, Element) :-
    ElementRow \== IndexRow,
    IndexRow1 is IndexRow + 1,
    IndexRow1 =< 10,
    show_list(Row2, IndexRow1, IndexColumn, ElementRow, ElementColumn, Element).

show_list([Row1 | _Row2], IndexRow, IndexColumn, ElementRow, ElementColumn, Element) :-
    ElementRow == IndexRow,
    show_row(Row1, IndexRow, IndexColumn, ElementRow, ElementColumn, Element).

show_row([_H | T], IndexRow, IndexColumn, ElementRow, ElementColumn, Element) :-
    ElementColumn \== IndexColumn,
    IndexColumn1 is IndexColumn + 1,
    show_row(T, IndexRow, IndexColumn1, ElementRow, ElementColumn, Element).

show_row([H | _T], _IndexRow, IndexColumn, _ElementRow, ElementColumn, Element) :-
    ElementColumn == IndexColumn,
    Element = H.



