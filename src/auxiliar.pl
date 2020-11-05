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

update_pos(Row, Col, CurrentBoard, NewBoard, Element) :-
    update_line(Row, Col, 1, 1, CurrentBoard, NewBoard, Element).

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

get_eat_dir(CurRow, CurCol, NextRow, NextCol, RowElem, ColElem) :-
    RowRest is NextRow - CurRow,
    ColRest is NextCol - CurCol,
    RowRest mod 2 =:= 0,
    ColRest mod 2 =:= 0,
    RowElem is RowRest // 2,
    ColElem is ColRest // 2.

is_consecutive(0).
is_consecutive(1).
is_consecutive(-1).

verify_equal(Elem, Elem, 1) :- !.
verify_equal(_, _, 0).

select_last_row([_, _, _, _, _, _, _, _, _, H | _], H).
select_first_col([H | _], H).

select_last_col([H | []], H) :- !.
select_last_col([_ | T], L) :- select_last_col(T, L).


