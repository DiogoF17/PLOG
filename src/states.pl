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
next_state:-
    o_eliminated(O),
    O =:= 10.

next_state:-
    x_eliminated(X),
    X =:= 10.

next_state:-
    z_eliminated(Z),
    Z =:= 10.

next_state:-
    o_eliminated(O),
    z_eliminated(Z),
    x_eliminated(X),
    O =\= 10, X =\= 10, Z =\= 10,
    play.
