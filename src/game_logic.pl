/* takes the current state and produces a new one according to the move*/
read_move(Board, Player, [[CurRow, CurCol, NextRow, NextCol] | Tail]) :-
    ask_user_move(CurRow, CurCol, NextRow, NextCol, Board, Player, EatMove),
    execute_move(EatMove, CurRow, CurCol, NextRow, NextCol, Player, 
             Board, Board1, _, _, _),
    keep_eating(EatMove, NextRow, NextCol, Board1, _, Player, Tail).

move(state(Board, Player, PlayerHasZ, XEliminated, OEliminated, ZEliminated),
    Move,
    state(NewBoard, NewPlayer, NewPlayerHasZ, NewXEliminated, NewYEliminated, NewZEliminated)) :-

    verifyEatMove(Move, Board, EatMove),
    execute_moves(Board, Player, XEliminated, OEliminated, ZEliminated,
                  Move, EatMove,
                  NewBoard, NewXEliminated, NewYEliminated, NewZEliminated),
    change_Player_Has_Z(EatMove, Player, PlayerHasZ, NewPlayerHasZ),
    next_player(Player, PlayerHasZ, NewPlayerHasZ, NewPlayer).
    
execute_moves(Board, _, XEliminated, OEliminated, ZEliminated,
              [[] | _], _,
              Board, XEliminated, OEliminated, ZEliminated).

execute_moves(Board, Player, XEliminated, OEliminated, ZEliminated,
              [[CurRow, CurCol, NextRow, NextCol] | NextPos], EatMove,
              NewBoard, NewXEliminated, NewOEliminated, NewZEliminated) :-

    execute_move(EatMove, CurRow, CurCol, NextRow, NextCol, Player, 
             Board, Board1, X1Eliminated, O1Eliminated, Z1Eliminated),
    X2Eliminated is X1Eliminated + XEliminated,
    O2Eliminated is O1Eliminated + OEliminated,
    Z2Eliminated is Z1Eliminated + ZEliminated,
    execute_moves(Board1, Player, X2Eliminated, O2Eliminated, Z2Eliminated,
                  NextPos, EatMove,
                  NewBoard, NewXEliminated, NewOEliminated, NewZEliminated).

/* ---------------------------------------------------------------- */
/*                          MOVES                                   */
/* ---------------------------------------------------------------- */

execute_move(EatMove, CurRow, CurCol, NextRow, NextCol, Player,
             Board, NewBoard, XEliminated, OEliminated, ZEliminated) :-

    remove_elem(CurRow, CurCol, Board, Board1),
    eat_elem(EatMove, CurRow, CurCol, NextRow, NextCol, 
             Board1, Board2, XEliminated, OEliminated, ZEliminated),
    insert_elem(NextRow, NextCol, Board2, NewBoard, Player).

/* ------------------- */

/* removes the element in the specified position */
remove_elem(Row, Col, Board, NewBoard) :-
    update_pos(Row, Col, Board, NewBoard, ' ').

/* ------------------- */

/* inserts the element in the specified position */
insert_elem(Row, Col, Board, NewBoard, Player) :-
    update_pos(Row, Col, Board, NewBoard, Player).

/* ------------------- */

/* In this case first argument indicates that the player didn't eta any piece */
eat_elem('n', _, _, _, _, 
        Board1, Board1, 0, 0, 0).

/* removes the element in the specified position incrementing the value of eaten peaces 
   of that specie and also changes z owner
   first argument indicates that in the movement of the player he eat a piece*/
eat_elem('y', CurRow, CurCol, NextRow, NextCol, 
        Board, NewBoard, XEliminated, OEliminated, ZEliminated) :-

    get_eat_dir(CurRow, CurCol, NextRow, NextCol, RowElem, ColElem),
    format("11\n", []),
    AuxRow is CurRow + RowElem, /* gets the row of the piece that we want to eat */
    format("12\n", []),
    AuxCol is CurCol + ColElem, /* gets the column of the piece that we want to eat */
    find_element(AuxRow, AuxCol, Board, ElementEaten),
    update_pos(AuxRow, AuxCol, Board, NewBoard, ' '),
    get_eliminated(ElementEaten, XEliminated, OEliminated, ZEliminated).

move_or_eat(Row, Col, CurRow, CurCol, _, 'n') :-
    is_adjacent(Row, Col, CurRow, CurCol), !.

move_or_eat(Row, Col, CurRow, CurCol, Board, 'y') :-
    can_eat(Row, Col, CurRow, CurCol, Board).

verifyEatMove([[CurRow, CurCol, NextRow, NextCol] | _], Board, 'y') :-
    can_eat(NextRow, NextCol, CurRow, CurCol, Board), !.

verifyEatMove(_, _, 'n').

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

get_eat_dir(CurRow, CurCol, NextRow, NextCol, RowElem, ColElem) :-
    RowRest is NextRow - CurRow,
    ColRest is NextCol - CurCol,
    RowRest mod 2 =:= 0,
    ColRest mod 2 =:= 0,
    RowElem is RowRest // 2,
    ColElem is ColRest // 2.

is_adjacent(Row, Col, CurRow, CurCol) :-
    Row >= CurRow - 1, Row =< CurRow + 1,
    Col >= CurCol - 1, Col =< CurCol + 1.

is_consecutive(0).
is_consecutive(1).
is_consecutive(-1).

/* ------------------- */

/* in case of the move of the user did not eat a piece */
keep_eating('n', _, _, Board3, Board3, _, [[]]).

/* in case of the move of the user ate a piece, asks to the user to keep eating
   if the answer is no than return the values*/
keep_eating('y', CurRow, CurCol, Board, NewBoard, Player, [H | T]) :-

    repeat,
        ask_keep_eating(Answer),
        process_answer(Answer, CurRow, CurCol, NextRow, NextCol, Board, Board1, Player, H),
    keep_eating(Answer, NextRow, NextCol, Board1, NewBoard, Player, T).

/* ------------------- */

process_answer('n', _, _, _, _, Board, Board, _, []) :- !.

/* in case of the move of the user ate a piece */
process_answer('y', CurRow, CurCol, NextRow, NextCol, Board, NewBoard, Player, [CurRow, CurCol, NextRow, NextCol]) :-
    display_board(Board),
    format('----------------------------------------\n\n', []),
    format('Current Row: ~p\nCurrent Column: ~p\n\n', [CurRow, CurCol]),
    ask_player_pos('Next Element', NextRow, NextCol), /* Asks the Position  where we want to move */
    verify_elem_in_pos(NextRow, NextCol, ' ', Board),
    can_eat(NextRow, NextCol, CurRow, CurCol, Board), !,
    format('\nValid Next Position!', []),
    execute_move('y', CurRow, CurCol, NextRow, NextCol, Player, 
             Board, NewBoard, _, _, _).

/* in case of the user doesn't insert a valid eat position */
process_answer(_, _, _, _, _, _, _, _, _) :-
    format("\nInvalid eat position", []),
    0 = 1. /* this way always returns false */

/* ---------------------------------------------------------------- */

get_eliminated('X', 1, 0, 0).
get_eliminated('O', 0, 1, 0).
get_eliminated('Z', 0, 0, 1).

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