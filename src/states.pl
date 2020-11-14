/* ----------------------------------------------
SELECTS THE NEXT STATE FROM THE CURRENT STATE: MAINMENU             
   ---------------------------------------------- */

next_state(mainMenu, Option) :-
    Option == 1,
    initial(State),
    play_human_vs_human(State).

next_state(mainMenu, Option) :-
    Option == 2,
    play_human_vs_pc.

next_state(mainMenu, Option) :-
    Option == 3,
    play_pc_vs_pc.

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
