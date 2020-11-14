/* ----------------------------------------------
SELECTS THE NEXT STATE FROM THE CURRENT STATE: MAINMENU             
   ---------------------------------------------- */

next_state(mainMenu, Option) :-
    Option == 1,
    initial(State),
    play_human_vs_human(State).

next_state(mainMenu, Option) :-
    Option == 2,
    menu_select_difficulty(OptionDifficulty),
    menu_select_piece(OptionPiece),
    get_piece(OptionPiece, Piece),
    get_difficulty(OptionDifficulty, Difficulty),
    initial(State),
    play_human_vs_pc(State, Piece, Difficulty).

next_state(mainMenu, Option) :-
    Option == 3,
    menu_select_difficulty(Difficulty),
    initial(State),
    play_pc_vs_pc(State, Difficulty).

get_piece(1, 'O').
get_piece(2, 'X').

get_difficulty(1, 'Easy').
get_difficulty(2, 'Medium').
get_difficulty(3, 'Hard').

/* ----------------------------------------------
SELECTS THE NEXT STATE FROM THE CURRENT STATE: BOARD             
   ---------------------------------------------- 
            Verifies if the game reach an end!
   ----------------------------------------------
*/

/* All pieces were eliminated! */
game_over(state(Board, _, _, XEliminated, OEliminated, ZEliminated), Winner):-
    OEliminated =:= 10, !,
    calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ),
    calcWinner(PontX, PontO, PontZ, Winner).

game_over(state(Board, _, _, XEliminated, OEliminated, ZEliminated), Winner):-
    XEliminated =:= 10, !,
    calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ),
    calcWinner(PontX, PontO, PontZ, Winner).

game_over(state(Board, _, _, XEliminated, OEliminated, ZEliminated), Winner):-
    ZEliminated =:= 10, !,
    calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ),
    calcWinner(PontX, PontO, PontZ, Winner).

/* All remaining pieces are touching the border of it's color */

game_over(state(Board, _, _, XEliminated, OEliminated, ZEliminated), Winner):-
    Remaining is 10 - OEliminated,
    count_O_touching_border(Board, Num),
    Remaining =:= Num, !,
    calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ),
    calcWinner(PontX, PontO, PontZ, Winner).

game_over(state(Board, _, _, XEliminated, OEliminated, ZEliminated), Winner):-
    Remaining is 10 - XEliminated,
    count_X_touching_border(Board, Num),
    Remaining =:= Num, !,
    calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ),
    calcWinner(PontX, PontO, PontZ, Winner).

game_over(state(Board, _, _, XEliminated, OEliminated, ZEliminated), Winner):-
    Remaining is 8 - ZEliminated,
    count_Z_touching_border(Board, Num),
    Remaining =:= Num,
    calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ),
    calcWinner(PontX, PontO, PontZ, Winner).
