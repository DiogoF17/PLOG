:- consult('lists.pl').
:- consult('board.pl').

game_human_vs_human :-
    player_turn(Element),
    printGame("HUMANO VS HUMANO"),
    rea_next_move(CurrentRow, CurrentColumn, NextRow, NextColumn, Element),
    update_board(CurrentRow, CurrentColumn, NextRow, NextColumn, Element).

game_human_vs_pc :-
    player_turn(Element),
    printGame("HUMANO VS PC"),
    rea_next_move(CurrentRow, CurrentColumn, NextRow, NextColumn, Element),
    update_board(CurrentRow, CurrentColumn, NextRow, NextColumn, Element). 

game_pc_vs_pc :-
    player_turn(Element),
    printGame("PC VS PC"),
    rea_next_move(CurrentRow, CurrentColumn, NextRow, NextColumn, Element),
    update_board(CurrentRow, CurrentColumn, NextRow, NextColumn, Element). 

rea_next_move(CurrentRow, CurrentColumn, NextRow, NextColumn, Element) :-
    format('----------------------------------------\n', []),
    format("\tWhat's your next move player: ~p\n", [Element]),
    format('----------------------------------------\n\n', []),
    ask_player_move('Current Element', CurrentRow, CurrentColumn, Element), /* Asks the curent Position of the element */
    format('\n----------------------------------------\n\n', []),
    ask_player_move('Next Element', NextRow, NextColumn, ' '). /* Asks the Position of the element where we want to move */

update_board(CurrentRow, CurrentCol, NextRow, NextCol, Element) :-
    board(Board),
    update_pos(CurrentRow, CurrentCol, Board, NewBoard, ' '), 
    update_pos(NextRow, NextCol, NewBoard, NewBoard1, Element),
    save_board(NewBoard1).

/* -------------------------------------- */
play :- 
    board(Board),
    player_turn(Player),
    display_game(Board, Player),
    rea_next_move(CurrentRow, CurrentColumn, NextRow, NextColumn, Player),
    update_board(CurrentRow, CurrentColumn, NextRow, NextColumn, Element). 
