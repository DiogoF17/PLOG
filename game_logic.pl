:- consult('lists.pl').
:- consult('board.pl').

:- dynamic player_turn/1.
:- dynamic z_belongs_to/1.

player_turn('O').
z_belongs_to('O').

readNextMove :-
    player_turn(Element),
    format('----------------------------------------\n', []),
    format("\tWhat's your next move player: ~p\n", [Element]),
    format('----------------------------------------\n\n', []),
    askPlayerMove(CurrentRow, CurrentColumn, Element),
    format('\n----------------------------------------\n\n', []),
    askPlayerMove(NextRow, NextColumn, ' '),
    update_board(CurrentRow, CurrentColumn, NextRow, NextColumn, Element).

askPlayerMove(Row, Column, Element) :-
    format('Curent Element Row: ', []), read(InputRow),
    format('Curent Element Column: ', []), read(InputColumn),
    valid_move(Row, Column, InputRow, InputColumn, Element).

valid_move(InputRow, InputColumn, InputRow, InputColumn, Element) :-
    integer(InputRow), integer(InputColumn), InputRow >= 1, InputRow =< 10, InputColumn >= 1, InputColumn =< InputRow,
    find_element(InputRow, InputColumn, Z), 
    Z == Element,
    format("\nValid Move!", []).

valid_move(Row, Column, _, _, Element) :-
    format('\nInvalid Move!\nCurent Element Row: ', []), read(InputRow),
    format('Curent Element Column: ', []), read(InputColumn),
    valid_move(Row, Column, InputRow, InputColumn, Element).

update_board(CurrentRow, CurrentCol, NextRow, NextCol, Element) :-
    board(Board),
    update_pos(CurrentRow, CurrentCol, Board, NewBoard, ' '), 
    update_pos(NextRow, NextCol, NewBoard, NewBoard1, Element),
    save_board(NewBoard1).
