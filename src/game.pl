:- consult('lists.pl').
:- consult('board.pl').
:- consult('player.pl').

play :- 
    board(Board), player_turn(Player),
    display_game(Board, Player),
    read_next_move(CurrentRow, CurrentColumn, NextRow, NextColumn, Player),
    update_board(CurrentRow, CurrentColumn, NextRow, NextColumn, Player),
    next_player(Player),
    next_state. 


