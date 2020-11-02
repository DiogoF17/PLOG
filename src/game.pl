:- consult('lists.pl').
:- consult('board.pl').
:- consult('player.pl').

play :- 
    repeat,
        board(Board), player_turn(Player),
        once(display_game(Board, Player)),
        once(read_next_move(CurrentRow, CurrentColumn, NextRow, NextColumn, Player)),
        once(update_board(CurrentRow, CurrentColumn, NextRow, NextColumn, Player)),
        once(next_player(Player)),
        endOfGame,
    end_game_menu.


