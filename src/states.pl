/* ----------------------------------------------
SELECTS THE NEXT STATE FROM THE CURRENT STATE: MAINMENU             
   ---------------------------------------------- */

next_state(mainMenu, Option) :-
    Option == 1,
    play_human_vs_human.

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
endOfGame(state(_, _, _, _, O_Eliminated, _)):-
    O_Eliminated =:= 10.

endOfGame(state(_, _, _, X_Eliminated, _, _)):-
    X_Eliminated =:= 10.

endOfGame(state(_, _, _, _, _, Z_Eliminated)):-
    Z_Eliminated =:= 10.

/* All remaining pieces are touching the border of it's color */

endOfGame(state(Board, _, _, _, O_Eliminated, _)):-
    Remaining is 10 - O_Eliminated,
    count_O_touching_border(Board, Num),
    Remaining =:= Num.

endOfGame(state(Board, _, _, X_Eliminated, _, _)):-
    Remaining is 10 - X_Eliminated,
    count_X_touching_border(Board, Num),
    Remaining =:= Num.

endOfGame(state(Board, _, _, _, _, Z_Eliminated)):-
    Remaining is 8 - Z_Eliminated,
    count_Z_touching_border(Board, Num),
    Remaining =:= Num.
