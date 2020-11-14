/* when we start to play the board is in this state */
initial(state(Board, 'O', 'O', 0, 0, 0)) :-
    initialBoard(Board).

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

display_game(state(Board, _, ZPlayer, XEliminated, OEliminated, ZEliminated), Player) :- 
    display_board(Board),
    display_number_eliminated(OEliminated, XEliminated, ZEliminated, ZPlayer),
    display_player_turn(Player).

display_board(Board) :-
    print_row1(Board).

print_row1([Row | Rest]) :-
    format("\n----------------------------------------------------------------------------------------------------------------\n", []),
    format("Board Representation: (Row)                   X# |(Col)Element | #O                                        (Row)\n", []),
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(1)                                              X# |(1) ~p | #O                                              (1)\n", Row),
    print_row2(Rest).

print_row2([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(2)                                           X# |(1) ~p |(2) ~p | #O                                          (2)\n", Row),
    print_row3(Rest).

print_row3([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(3)                                        X# |(1) ~p |(2) ~p |(3) ~p | #O                                      (3)\n", Row),
    print_row4(Rest).

print_row4([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(4)                                     X# |(1) ~p |(2) ~p |(3) ~p |(4) ~p | #O                                  (4)\n", Row),
    print_row5(Rest).

print_row5([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(5)                                  X# |(1) ~p |(2) ~p |(3) ~p |(4) ~p |(5) ~p | #O                              (5)\n", Row),
    print_row6(Rest).

print_row6([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(6)                               X# |(1) ~p |(2) ~p |(3) ~p |(4) ~p |(5) ~p |(6) ~p | #O                          (6)\n", Row),
    print_row7(Rest).

print_row7([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(7)                           X# |(1) ~p |(2) ~p |(3) ~p |(4) ~p |(5) ~p |(6) ~p |(7) ~p | #O                       (7)\n", Row),
    print_row8(Rest).

print_row8([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(8)                       X# |(1) ~p |(2) ~p |(3) ~p |(4) ~p |(5) ~p |(6) ~p |(7) ~p |(8) ~p | #O                    (8)\n", Row),
    print_row9(Rest).

print_row9([Row | Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(9)                   X# |(1) ~p |(2) ~p |(3) ~p |(4) ~p |(5) ~p |(6) ~p |(7) ~p |(8) ~p |(9) ~p | #O                 (9)\n", Row),
    print_row10(Rest).

print_row10([Row | _Rest]) :-
    format("----------------------------------------------------------------------------------------------------------------\n", []),
    format("(10)              X# |(1) ~p |(2) ~p |(3) ~p |(4) ~p |(5) ~p |(6) ~p |(7) ~p |(8) ~p |(9) ~p |(10) ~p | #O            (10)\n", Row),
    format("                  ##############################################################################\n", []),
    format("                        Z      Z      Z      Z      Z      Z      Z      Z      Z      Z\n\n", []).


display_number_eliminated(O, X, Z, ZPlayer) :-
    format("------------------------------\n", []),
    format("  Number of Eliminated Elements \n", []),
    format("------------------------------\n", []),
    format("  O: ~p                       \n", [O]),
    format("  X: ~p                       \n", [X]),
    format("  Z: ~p                       \n", [Z]),
    format("------------------------------\n", []),
    format("  Z belongs to -> ~p                       \n", [ZPlayer]),
    format("------------------------------\n", []).

display_player_turn(Player) :-
     format("  PLAYER TURN: ~p\n", [Player]).