/* ===================================
            FIND
   =================================== */   

find_element(ElementRow, ElementColumn, Board, Element) :-
    find_row(Board, 1, 1, ElementRow, ElementColumn, Element).

find_row([_Row1 | Row2], IndexRow, IndexColumn, ElementRow, ElementColumn, Element) :-
    ElementRow \== IndexRow,
    IndexRow1 is IndexRow + 1,
    IndexRow1 =< 10,
    find_row(Row2, IndexRow1, IndexColumn, ElementRow, ElementColumn, Element).

find_row([Row1 | _Row2], IndexRow, IndexColumn, ElementRow, ElementColumn, Element) :-
    ElementRow == IndexRow,
    find_column(Row1, IndexRow, IndexColumn, ElementRow, ElementColumn, Element).

find_column([_H | T], IndexRow, IndexColumn, ElementRow, ElementColumn, Element) :-
    ElementColumn \== IndexColumn,
    IndexColumn1 is IndexColumn + 1,
    find_column(T, IndexRow, IndexColumn1, ElementRow, ElementColumn, Element).

find_column([H | _T], _IndexRow, IndexColumn, _ElementRow, ElementColumn, Element) :-
    ElementColumn == IndexColumn,
    Element = H.

/* ===================================
            SUBSTITUTE
   =================================== */         

update_pos(Row, Col, Board, NewBoard, Element) :-
    update_line(Row, Col, 1, 1, Board, NewBoard, Element).

update_line(Row, Col, IndexRow, IndexCol, [H1 | T1], [H1 | T2], Element) :-
    IndexRow < Row,
    IndexRow1 is IndexRow + 1,
    update_line(Row, Col, IndexRow1, IndexCol, T1, T2, Element).

update_line(Row, Col, IndexRow, IndexCol, [H1 | T1], [H2 | T1], Element) :-
    IndexRow == Row,
    update_col(Col, IndexCol, H1, H2, Element).

update_col(Col, IndexCol, [H1 | T1], [H1 | T2], Element) :-
    IndexCol < Col,
    IndexCol1 is IndexCol + 1,
    update_col(Col, IndexCol1, T1, T2, Element).

update_col(Col, IndexCol, [_ | T1], [Element | T1], Element) :-
    IndexCol == Col.

/* ------------------------------------ */

select_last_row([_, _, _, _, _, _, _, _, _, H | _], H).
select_first_col([H | _], H).

select_last_col([H | []], H) :- !.
select_last_col([_ | T], L) :- select_last_col(T, L).

/* ------------------------------------ */

verify_equal(Elem, Elem, 1) :- !.
verify_equal(_, _, 0).

/* ------------------------------------ */

verify_elem_in_pos(Row, Col, Element, Board) :-
    integer(Row), integer(Col), Row >= 1, Row =< 10, Col >= 1, Col =< Row,
    find_element(Row, Col, Board, Z), 
    Z == Element.

/* ------------------------------------ */

verifyEatMove([[Row, Col, NextRow, NextCol] | _], Board, EatMove) :-
    type_of_move(Row, Col, NextRow, NextCol, Board, EatMove).

/*------- NORMAL MOVES --------*/

type_of_move(Row, Col, NextRow, NextCol, _, 'n') :-
    AuxCol is Col - 1,
    NextRow = Row, NextCol = AuxCol, !.

type_of_move(Row, Col, NextRow, NextCol, _, 'n') :-
    AuxCol is Col + 1,
    NextRow = Row, NextCol = AuxCol, !.

type_of_move(Row, Col, NextRow, NextCol, _, 'n') :-
    AuxRow is Row - 1,
    AuxCol is Col - 1,
    NextRow = AuxRow, NextCol = AuxCol, !.

type_of_move(Row, Col, NextRow, NextCol, _, 'n') :-
    AuxRow is Row - 1,
    NextRow = AuxRow, NextCol = Col, !.

type_of_move(Row, Col, NextRow, NextCol, _, 'n') :-
    AuxRow is Row + 1,
    NextRow = AuxRow, NextCol = Col, !.

type_of_move(Row, Col, NextRow, NextCol, _, 'n') :-
    AuxRow is Row + 1,
    AuxCol is Col + 1,
    NextRow = AuxRow, NextCol = AuxCol, !.

/*------- EAT MOVES --------*/

type_of_move(Row, Col, NextRow, NextCol, Board, 'y') :-
    AuxCol is Col - 2,
    NextRow = Row, NextCol = AuxCol, !,
    AuxCol1 is Col - 1,
    find_element(Row, AuxCol1, Board, Elem),
    Elem \= ' '.

type_of_move(Row, Col, NextRow, NextCol, Board, 'y') :-
    AuxCol is Col + 2,
    NextRow = Row, NextCol = AuxCol, !,
    AuxCol1 is Col + 1,
    find_element(Row, AuxCol1, Board, Elem),
    Elem \= ' '.

type_of_move(Row, Col, NextRow, NextCol, Board, 'y') :-
    AuxRow is Row - 2,
    AuxCol is Col - 2,
    NextRow = AuxRow, NextCol = AuxCol, !,
    AuxRow1 is Row - 1,
    AuxCol1 is Col - 1,
    find_element(AuxRow1, AuxCol1, Board, Elem),
    Elem \= ' '.

type_of_move(Row, Col, NextRow, NextCol, Board, 'y') :-
    AuxRow is Row - 2,
    NextRow = AuxRow, NextCol = Col, !,
    AuxRow1 is Row - 1,
    find_element(AuxRow1, Col, Board, Elem),
    Elem \= ' '.

type_of_move(Row, Col, NextRow, NextCol, Board, 'y') :-
    AuxRow is Row + 2,
    NextRow = AuxRow, NextCol = Col, !,
    AuxRow1 is Row + 1,
    find_element(AuxRow1, Col, Board, Elem),
    Elem \= ' '.

type_of_move(Row, Col, NextRow, NextCol, Board, 'y') :-
    AuxRow is Row + 2,
    AuxCol is Col + 2,
    NextRow = AuxRow, NextCol = AuxCol,
    AuxRow1 is Row + 1,
    AuxCol1 is Col + 1,
    find_element(AuxRow1, AuxCol1, Board, Elem),
    Elem \= ' '.

/* ------------------------------------ */

get_eat_dir(Row, Col, NextRow, NextCol, RowElem, ColElem) :-
    RowRest is NextRow - Row,
    ColRest is NextCol - Col,
    RowRest mod 2 =:= 0,
    ColRest mod 2 =:= 0,
    RowElem is RowRest // 2,
    ColElem is ColRest // 2.

/* ------------------------------------ */

get_eliminated('X', 1, 0, 0).
get_eliminated('O', 0, 1, 0).
get_eliminated('Z', 0, 0, 1).

/* ------------------------------------ */

count_X_touching_border(Board, Res) :-
    count_X(1, Board, Res).

count_X(Row, [H | _], Res) :-
    Row =:= 10,
    select_first_col(H, Elem),
    verify_equal(Elem, 'X', Res).

count_X(Row, [H | T], Res) :-
    Row < 10,
    Row1 is Row + 1,
    select_first_col(H, Elem),
    verify_equal(Elem, 'X', Num1),
    count_X(Row1, T, Res1),
    Res is Res1 + Num1.

count_O_touching_border(Board, Res) :-
    count_O(1, Board, Res).

count_O(Row, [H | _], Res) :-
    Row =:= 10,
    select_last_col(H, Elem),
    verify_equal(Elem, 'O', Res).

count_O(Row, [H | T], Res) :-
    Row < 10,
    Row1 is Row + 1,
    select_last_col(H, Elem),
    verify_equal(Elem, 'O', Num1),
    count_O(Row1, T, Res1),
    Res is Res1 + Num1.

count_Z_touching_border(Board, Res) :-
    select_last_row(Board, L),
    count_Z(1, L, Res).

count_Z(Col, [H | _], Res) :-
    Col =:= 10,
    verify_equal(H, 'Z', Res).

count_Z(Col, [H | T], Res) :-
    Col < 10,
    Col1 is Col + 1,
    verify_equal(H, 'Z', Num1),
    count_Z(Col1, T, Res1),
    Res is Res1 + Num1.

/* ------------------------------------ */

calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ) :-
    count_X_touching_border(Board, BorderX), 
    count_O_touching_border(Board, BorderO), 
    count_Z_touching_border(Board, BorderZ),
    PontX is (OEliminated + ZEliminated + (2 * BorderX)),
    PontO is (XEliminated + ZEliminated + (2 * BorderO)),
    PontZ is (XEliminated + OEliminated + (2 * BorderZ)).

calcWinner(PontX, PontO, PontZ, 'O') :-
    PontO > PontX, PontO > PontZ, !.

calcWinner(PontX, PontO, PontZ, 'X') :-
    PontX > PontO, PontX > PontZ, !.

calcWinner(PontX, PontO, PontZ, 'Z') :-
    PontZ > PontO, PontZ > PontX, !.

calcWinner(_, _, _, ' ').


