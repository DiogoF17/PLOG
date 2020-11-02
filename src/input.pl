ask_menu_option(Option, Limit) :-
    format('\nInsira a sua opcao: ', []), read(UserInput),
    verify_menu_option(UserInput, Option, Limit).

verify_menu_option(Option, Option, Limit) :-
    integer(Option), Option >= 1, Option =< Limit.

verify_menu_option(_, Option, Limit) :-
    format("\nOpcao Invalida! Tente novamente: ", []), read(X),
    verify_menu_option(X, Option, Limit).

ask_player_pos(Msg, Row, Column) :-
    format('~p Row: ', [Msg]), read(Row),
    format('~p Column: ', [Msg]), read(Column).

valid_cur_pos(Row, Col, Element) :-
    integer(Row), integer(Col), Row >= 1, Row =< 10, Col >= 1, Col =< Row,
    find_element(Row, Col, Z), 
    Z == Element, !,
    format("\nValid Current Position!", []).

valid_cur_pos(_, _, Element) :-
    format("\nInvalid Current Position for Element: ~p\n", [Element]),
    0 = 1. /* this way always returns false */

valid_next_pos(NextRow, NextCol, CurRow, CurCol) :-
    integer(NextRow), integer(NextCol), NextRow >= 1, NextRow =< 10, NextCol >= 1, NextCol =< NextRow,
    find_element(NextRow, NextCol, Z), 
    Z == ' ',
    move_or_eat(NextRow, NextCol, CurRow, CurCol), !,
    format("\nValid Next Position!", []).

valid_next_pos(_, _, _, _) :-
    format("\nInvalid Next Position! \n", []),
    0 = 1. /* this way always returns false */

move_or_eat(Row, Col, CurRow, CurCol) :-
    is_adjacent(Row, Col, CurRow, CurCol), !.

move_or_eat(Row, Col, CurRow, CurCol) :-
    eat(Row, Col, CurRow, CurCol).

is_adjacent(Row, Col, CurRow, CurCol) :-
    Row >= CurRow - 1, Row =< CurRow + 1,
    Col >= CurCol - 1, Col =< CurCol + 1.

eat(Row, Col, CurRow, CurCol) :-
    is_valid_eat_pos(Row, Col, CurRow, CurCol, RowElem, ColElem),
    AuxRow is CurRow + RowElem,
    AuxCol is CurCol + ColElem,
    find_element(AuxRow, AuxCol, Z),
    Z \== ' ',
    remove_element(AuxRow, AuxCol, Z).

is_valid_eat_pos(Row, Col, CurRow, CurCol, RowElem, ColElem) :-
    RowRest is Row - CurRow,
    ColRest is Col - CurCol,
    RowRest mod 2 =:= 0,
    ColRest mod 2 =:= 0,
    RowElem is RowRest // 2,
    is_consecutive(RowElem),
    ColElem is ColRest // 2,
    is_consecutive(ColElem).

is_consecutive(0).
is_consecutive(1).
is_consecutive(-1).


