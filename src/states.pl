/* ----------------------------------------------
SELECTS THE NEXT STATE FROM THE CURRENT STATE: MAINMENU             
   ---------------------------------------------- */

next_state(mainMenu, Option) :-
    Option == 1,
    initial(Board), save_board(Board),
    play.

next_state(mainMenu, Option) :-
    Option == 2,
    initial(Board), save_board(Board),
    play.

next_state(mainMenu, Option) :-
    Option == 3,
    initial(Board), save_board(Board),
    play.

/* ----------------------------------------------
SELECTS THE NEXT STATE FROM THE CURRENT STATE: BOARD             
   ---------------------------------------------- 
            Verifies if the game reach an end!
   ----------------------------------------------
*/

                /* All pieces were eliminated! */
endOfGame:-
    o_eliminated(O),
    O =:= 10.

endOfGame:-
    x_eliminated(X),
    X =:= 10.

endOfGame:-
    z_eliminated(Z),
    Z =:= 10.

                /* All remaining pieces are touching the border of it's color */

endOfGame:-
    o_eliminated(O),
    Remaining is 10 - O,
    count_O_touching_border(Num),
    Remaining =:= Num.

endOfGame:-
    x_eliminated(X),
    Remaining is 10 - X,
    count_X_touching_border(Num),
    Remaining =:= Num.

endOfGame:-
    z_eliminated(Z),
    Remaining is 8 - Z,
    count_Z_touching_border(Num),
    Remaining =:= Num.
