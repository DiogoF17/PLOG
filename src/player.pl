:- dynamic player_turn/1.
:- dynamic z_belongs_to/1.
:- dynamic o_eliminated/1.
:- dynamic x_eliminated/1.
:- dynamic z_eliminated/1.

player_turn('O'). /* current player */
z_belongs_to('O'). /* the z belongs to player */

o_eliminated(0). /* numbers of eliminated Os */
x_eliminated(0). /* numbers of eliminated Xs */
z_eliminated(0). /* numbers of eliminated Zs */

/* saves the board state */
save_board(Board) :-
    retract(board(_)),
    assert(board(Board)).

/* saves the next player */
save_next_player(Player) :-
    retract(player_turn(_)),
    assert(player_turn(Player)).

/* saves the player that holds the Zs */
save_z_belongs_to(Player) :-
    retract(z_belongs_to(_)),
    assert(z_belongs_to(Player)).

/* -------------------------------------- */

read_next_move(CurRow, CurCol, NextRow, NextCol, Element) :-
    format('----------------------------------------\n', []),
    format("\tMOVE FROM PLAYER: ~p\n", [Element]),
    repeat,
        format('----------------------------------------\n\n', []),
        ask_player_pos('Current Element', CurRow, CurCol), /* Asks the curent Position of the element */
        once(valid_cur_pos(CurRow, CurCol, Element)),
        format('\n----------------------------------------\n\n', []),
        once(ask_player_pos('Next Element', NextRow, NextCol)), /* Asks the Position  where we want to move */
        valid_next_pos(NextRow, NextCol, CurRow, CurCol).

/* -------------------------------------- 
           SELECTS THE NEXT PLAYER
   -------------------------------------- */ 

next_player(Player) :-
    Player = 'O', 
    z_belongs_to(Player1), Player1 = 'O',
    save_next_player('Z').

next_player(Player) :-
    Player = 'X', 
    z_belongs_to(Player1), Player1 = 'X',
    save_next_player('Z').

next_player(Player) :-
    Player = 'X', 
    z_belongs_to(Player1), Player1 = 'O',
    save_next_player('O').

next_player(Player) :-
    Player = 'Y', 
    z_belongs_to(Player1), Player1 = 'X',
    save_next_player('X').

next_player(Player) :-
    Player = 'Z', 
    z_belongs_to(Player1), Player1 = 'X',
    save_next_player('O').

next_player(Player) :-
    Player = 'Z', 
    z_belongs_to(Player1), Player1 = 'O',
    save_next_player('X').