/* when we start to play the board is in this state */
initial([
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

intermediate1([
    ['O'],
    [' ', 'X'],
    ['Z', 'X', 'O'],
    ['O', 'Z', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', 'O', ' ', ' ', ' '],
    [' ', 'X', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', 'O', ' ', ' '],
    [' ', 'X', ' ', ' ', 'Z', ' ', ' ', ' ', ' ', ' ']]).

intermediate2([
    ['O'],
    [' ', 'X'],
    ['Z', 'X', 'O'],
    ['O', 'Z', 'X', ' '],
    [' ', ' ', 'Z', 'Z', ' '],
    [' ', ' ', ' ', ' ', 'O', ' '],
    [' ', 'X', ' ', 'O', ' ', ' ', ' '],
    [' ', 'X', 'O', ' ', 'Z', ' ', ' ', ' '],
    ['X', ' ', 'Z', ' ', ' ', ' ', 'O', 'O', 'O'],
    [' ', 'X', ' ', ' ', 'Z', ' ', ' ', ' ', ' ', ' ']]).

intermediate3([
    [' '],
    ['Z', ''],
    [' ', ' ', 'O'],
    [' ', 'Z', 'X', ' '],
    [' ', ' ', 'Z', 'Z', ' '],
    [' ', ' ', ' ', ' ', 'O', ' '],
    [' ', '', ' ', 'O', ' ', ' ', 'X'],
    [' ', '', 'X', ' ', 'Z', ' ', ' ', ' '],
    ['X', 'O', '', ' ', ' ', ' ', 'O', 'O', 'O'],
    ['Z', 'X', ' ', ' ', ' ', ' ', 'O', ' ', ' ', 'X']]).

final([
    ['O'],
    [' ', 'X'],
    [' ', 'X', 'O'],
    ['O', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', 'O', ' ', ' ', ' '],
    [' ', 'X', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', 'O', ' ', ' '],
    ['Z', 'X', ' ', ' ', 'Z', 'Z', ' ', ' ', ' ', ' ']]).


/* --------------------------------------------- 
                DISPLAY FUNCTIONS
   --------------------------------------------- */

display_game(Board, _Player) :- 
    print_row1(Board).

print_row1([Row | Rest]) :-
    format("\n\n\n                        X#   #O                                   |   Tabuleiro Auxiliar que indica a posicao dos              X#   #O\n", []),
    format("                      X# | ~p | #O                                 |      elementos atraves de (Row, Column)               X# | (1, 1) | #O\n", Row),
    print_row2(Rest).

print_row2([Row | Rest]) :-
    format("                    X# | ~p | ~p | #O                               |                                                   X# | (2, 1) | (2, 2) | #O\n", Row),
    print_row3(Rest).

print_row3([Row | Rest]) :-
    format("                  X# | ~p | ~p | ~p | #O                             |                                               X# | (3, 1) | (3, 2) | (3, 3) | #O\n", Row),
    print_row4(Rest).

print_row4([Row | Rest]) :-
    format("                X# | ~p | ~p | ~p | ~p | #O                           |                                           X# | (4, 1) | (4, 2) | (4, 3) | (4, 4) | #O\n", Row),
    print_row5(Rest).

print_row5([Row | Rest]) :-
    format("              X# | ~p | ~p | ~p | ~p | ~p | #O                         |                                       X# | (5, 1) | (5, 2) | (5, 3) | (5, 4) | (5, 5) | #O\n", Row),
    print_row6(Rest).

print_row6([Row | Rest]) :-
    format("            X# | ~p | ~p | ~p | ~p | ~p | ~p | #O                       |                                   X# | (6, 1) | (6, 2) | (6, 3) | (6, 4) | (6, 5) | (6, 6) | #O\n", Row),
    print_row7(Rest).

print_row7([Row | Rest]) :-
    format("          X# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #O                     |                                X# | (7, 1) | (7, 2) | (7, 3) | (7, 4) | (7, 5) | (7, 6) | (7, 7) | #O\n", Row),
    print_row8(Rest).

print_row8([Row | Rest]) :-
    format("        X# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #O                   |                            X# | (8, 1) | (8, 2) | (8, 3) | (8, 4) | (8, 5) | (8, 6) | (8, 7) | (8, 8) | #O\n", Row),
    print_row9(Rest).

print_row9([Row | Rest]) :-
    format("      X# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #O                 |                        X# | (9, 1) | (9, 2) | (9, 3) | (9, 4) | (9, 5) | (9, 6) | (9, 7) | (9, 8) | (9, 9) | #O\n", Row),
    print_row10(Rest).

print_row10([Row | _Rest]) :-
    format("    X# | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | ~p | #O               |               X# | (10, 1) | (10, 2) | (10, 3) | (10, 4) | (10, 5) | (10, 6) | (10, 7) | (10, 8) | (10, 9) | (10, 10) | #O\n", Row),
    format("       #########################################                                     ######################################################################################################\n", []),
    format("           Z   Z   Z   Z   Z   Z   Z   Z   Z   Z                                          Z         Z         Z         Z         Z         Z         Z         Z         Z         Z\n\n", []).


display_pontuations(O, X, Z, Player) :-
    format("------------------------------\n", []),
    format("  Number Elements Eliminated \n", []),
    format("------------------------------\n", []),
    format("  O: ~p                       \n", [O]),
    format("  X: ~p                       \n", [X]),
    format("  Z: ~p                       \n", [Z]),
    format("------------------------------\n", []),
    format("  Z belongs to -> ~p                       \n", [Player]),
    format("------------------------------\n\n", []).