ask_menu_option(Option, Limit) :-
    format('\nOption: ', []), read(UserInput),
    verify_menu_option(UserInput, Option, Limit).

verify_menu_option(Option, Option, Limit) :-
    integer(Option), Option >= 1, Option =< Limit.

verify_menu_option(_, Option, Limit) :-
    format("\nInvalid Option! Try again: ", []), read(X),
    verify_menu_option(X, Option, Limit).

ask_player_pos(Msg, Row, Column) :-
    format('~p Row: ', [Msg]), read(Row),
    format('~p Column: ', [Msg]), read(Column).

valid_cur_pos(Row, Col, Board, Element) :-
    integer(Row), integer(Col), Row >= 1, Row =< 10, Col >= 1, Col =< Row,
    find_element(Row, Col, Board, Z), 
    Z == Element, !,
    format("\nValid Current Position!", []).

valid_cur_pos(_, _, _, Element) :-
    format("\nInvalid Current Position for Element: ~p\n", [Element]),
    0 = 1. /* this way always returns false */

valid_next_pos(NextRow, NextCol, CurRow, CurCol, Board, Eat) :-
    integer(NextRow), integer(NextCol), NextRow >= 1, NextRow =< 10, NextCol >= 1, NextCol =< NextRow,
    find_element(NextRow, NextCol, Board, Z), 
    Z == ' ',
    move_or_eat(NextRow, NextCol, CurRow, CurCol, Board, Eat), !,
    format("\nValid Next Position!", []).

valid_next_pos(_, _, _, _, _, _) :-
    format("\nInvalid Next Position! \n", []),
    0 = 1. /* this way always returns false */

move_or_eat(Row, Col, CurRow, CurCol, _, 0) :-
    is_adjacent(Row, Col, CurRow, CurCol), !.

move_or_eat(Row, Col, CurRow, CurCol, Board, 1) :-
    can_eat(Row, Col, CurRow, CurCol, Board).

is_adjacent(Row, Col, CurRow, CurCol) :-
    Row >= CurRow - 1, Row =< CurRow + 1,
    Col >= CurCol - 1, Col =< CurCol + 1.

can_eat(Row, Col, CurRow, CurCol, Board) :-
    is_valid_eat_pos(Row, Col, CurRow, CurCol, RowElem, ColElem),
    AuxRow is CurRow + RowElem,
    AuxCol is CurCol + ColElem,
    find_element(AuxRow, AuxCol, Board, Z),
    Z \== ' '.

is_valid_eat_pos(Row, Col, CurRow, CurCol, RowElem, ColElem) :-
    get_eat_dir(CurRow, CurCol, Row, Col, RowElem, ColElem),
    is_consecutive(RowElem),
    is_consecutive(ColElem).


