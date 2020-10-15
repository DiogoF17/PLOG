:- consult('lists.pl').
:- consult('board.pl').

:- dynamic player_turn/1.
:- dynamic z_belongs_to/1.

player_turn('O').
z_belongs_to('O').

readNextMove :-
    player_turn(X),
    format('----------------------------------------\n', []),
    format("\tWhat's your next move player: ~p\n", [X]),
    format('----------------------------------------\n\n', []),
    read_current(CurrentRow, CurrentColumn),
    read_next(NextRow, NextColumn),
    update_board(CurrentRow, CurrentColumn, NextRow, NextColumn).

read_current(CurrentRow, CurrentColumn) :-
    format('Curent Element Row: ', []), read(CurrentRow),
    format('Curent Element Column: ', []), read(CurrentColumn),
    valid_move_current(CurrentRow, CurrentColumn).

read_next(NextRow, NextColumn) :-
    format('\n----------------------------------------\n\n', []),
    format('Next Element Row: ', []), read(NextRow),
    format('Next Element Column: ', []), read(NextColumn),
    valid_move_next(NextRow, NextColumn).

valid_move_current(Row, Column) :-
    integer(Row), integer(Column), Row >= 1, Row =< 10, Column >= 1, Column =< Row,
    find_element(Row, Column, X), 
    format('Element: ~p\n\n', [X]),
    player_turn(Y),
    X == Y,
    format("\nValid Move!", []).

valid_move_current(_, _) :-
    format('\nInvalid Move!\nCurent Element Row: ', []), read(CurrentRow),
    format('Curent Element Column: ', []), read(CurrentColumn),
    valid_move_current(CurrentRow, CurrentColumn).


valid_move_next(Row, Column) :-
    integer(Row), integer(Column), Row >= 1, Row =< 10, Column >= 1, Column =< Row,
    find_element(Row, Column, X), 
    format('Element: ~p\n\n', [X]),
    X == ' ',
    format('\nValid Move!', []).

valid_move_next(_, _) :-
    format('\nInvalid Move!\nNext Element Row: ', []), read(NextRow),
    format('Next Element Column: ', []), read(NextColumn),
    valid_move_next(NextRow, NextColumn).

update_board(CurrentRow, CurrentCol, NextRow, NextCol) :-
    board(Board), player_turn(Element),
    update_pos(CurrentRow, CurrentCol, Board, NewBoard, ' '), 
    update_pos(NextRow, NextCol, NewBoard, NewBoard1, Element),
    printBoard(NewBoard1, 'o'),
    save_board(NewBoard1).
