:- use_module(library(lists)).

get_move(state(Board, Player, _, _, _, _), 'None', _, Move) :-
    !,
    user_move(Board, Player, Move).

get_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), 'All', Level, Move) :-
    !,
    pc_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player, Level, Move).

get_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player, Level, Move) :-
    !,
    pc_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),  Player, Level, Move).

get_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), ZPlayer, Level, Move) :-
    !,
    pc_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player, Level, Move).

get_move(state(Board, Player, _, _, _, _), _, _, Move) :-
    user_move(Board, Player, Move).

/* takes the current state and produces a new one according to the move*/
user_move(Board, Player, [[Row, Col, NextRow, NextCol] | Tail]) :-
    ask_user_move(Row, Col, NextRow, NextCol, Board, Player, EatMove),
    execute_move(EatMove, Row, Col, NextRow, NextCol, Player, 
             Board, Board1, _, _, _),
    keep_eating(EatMove, NextRow, NextCol, Board1, _, Player, Tail).


pc_move(GameState, Player, Level, Move) :-
    choose_move(GameState, Player, Level, Move),
    can_show_pc_move(Answer),
    show_pc_move(Move, Answer).

choose_move(GameState, Player, Level, Move) :-
    valid_moves(GameState, Player, ListOfMoves),
    calc_values(GameState, Player, ListOfMoves, ListMovesWithValues),
    sort(ListMovesWithValues, ListMovesWithValuesSorted),
    choose_move(Level, ListMovesWithValuesSorted, Move).

choose_move('Easy', [ MoveWithValue | _], Move) :- !, getMove(MoveWithValue, Move).

choose_move('Hard', MovesWithValue, Move) :- 
    !, last(MovesWithValue, MoveWithValue), 
    getMove(MoveWithValue, Move).

choose_move('Medium', MovesWithValue, Move) :- 
    length(MovesWithValue, Size), 
    MediumElem is round(Size/2), 
    nth1(MediumElem, MovesWithValue, MoveWithValue), 
    getMove(MoveWithValue, Move).

getMove([_ | [Move]], Move).

valid_moves(state(Board, _, _, _, _, _), Player, ListOfMoves) :-
    get_row_num(Board, Player, [], ListOfPos, 1),
    get_valid_adj_pos(Board, ListOfPos, [], ListOfMoves1),
    assert(listEat([])),
    get_valid_eat_pos(Board, Player, ListOfPos),
    retract(listEat(ListOfMoves2)),
    append(ListOfMoves1, ListOfMoves2, ListOfMoves3),
    remove_empty_lists(ListOfMoves3, ListOfMoves).

remove_empty_lists([], []).
remove_empty_lists([[] | T], List) :- remove_empty_lists(T, List).
remove_empty_lists([H | T1], [H | T2]) :- remove_empty_lists(T1, T2).

get_valid_eat_pos(_, _, []).

get_valid_eat_pos(Board, Player, [[Row, Col] | T1]) :-
    eat_all_dir(Board, Player, Row, Col, []),
    get_valid_eat_pos(Board, Player, T1).

add_eat_pos(Board, Player, Row, Col, NextRow, NextCol, Move) :-
    verify_elem_in_pos(NextRow, NextCol, ' ', Board),
    type_of_move(Row, Col, NextRow, NextCol, Board, 'y'), !,
    execute_move('y', Row, Col, NextRow, NextCol, Player, Board, NewBoard, _, _, _),
    append(Move, [[Row, Col, NextRow, NextCol]], Aux),
    retract(listEat(Aux1)),
    append(Aux1, [Aux], Aux2),
    assert(listEat(Aux2)),
    eat_all_dir(NewBoard, Player, NextRow, NextCol, Aux).

add_eat_pos(_, _, _, _, _, _, _).

eat_all_dir(Board, Player, Row, Col, Move) :-
    ColBefore is Col - 2, ColAfter is Col + 2,
    RowBefore is Row - 2, RowAfter is Row + 2,
    add_eat_pos(Board, Player, Row, Col, Row, ColBefore, Move),
    add_eat_pos(Board, Player, Row, Col, Row, ColAfter, Move),
    add_eat_pos(Board, Player, Row, Col, RowBefore, ColBefore, Move),
    add_eat_pos(Board, Player, Row, Col, RowBefore, Col, Move),
    add_eat_pos(Board, Player, Row, Col, RowAfter, Col, Move),
    add_eat_pos(Board, Player, Row, Col, RowAfter, ColAfter, Move).

get_valid_adj_pos(_, [], ListOfMoves, ListOfMoves).

get_valid_adj_pos(Board, [[Row, Col] | T1], Aux, ListOfMoves) :-
    ColBefore is Col - 1, ColAfter is Col + 1,
    RowBefore is Row - 1, RowAfter is Row + 1,
    add_adj_pos(Board, Row, Col, Row, ColBefore, Aux1), append(Aux, [Aux1], Aux2),
    add_adj_pos(Board, Row, Col, Row, ColAfter, Aux3), append(Aux2, [Aux3], Aux4),
    add_adj_pos(Board, Row, Col, RowBefore, ColBefore, Aux5), append(Aux4, [Aux5], Aux6),
    add_adj_pos(Board, Row, Col, RowBefore, Col, Aux7), append(Aux6, [Aux7], Aux8),
    add_adj_pos(Board, Row, Col, RowAfter, Col, Aux9), append(Aux8, [Aux9], Aux10),
    add_adj_pos(Board, Row, Col, RowAfter, ColAfter, Aux11), append(Aux10, [Aux11], Aux12),
    get_valid_adj_pos(Board, T1, Aux12, ListOfMoves).

add_adj_pos(Board, Row, Col, NextRow, NextCol, [[Row, Col, NextRow, NextCol]]) :-
    verify_elem_in_pos(NextRow, NextCol, ' ', Board), !.

add_adj_pos(_, _, _, _, _, []).

get_row_num([], _, Result, Result, _).

get_row_num([H | T], Player, Aux, Result, RowNum) :-
    get_col_num(H, Player, Aux1, RowNum, 1),
    append(Aux1, Aux, Aux2),
    RowNum1 is RowNum + 1,
    get_row_num(T, Player, Aux2, Result, RowNum1).

get_col_num([], _, [], _, _).

get_col_num([Player | T1], Player, [[RowNum, ColNum] | T2], RowNum, ColNum) :-
    ColNum1 is ColNum + 1, !,
    get_col_num(T1, Player, T2, RowNum, ColNum1).

get_col_num([_ | T], Player, ListOfPos, RowNum, ColNum) :-
    ColNum1 is ColNum + 1,
    get_col_num(T, Player, ListOfPos, RowNum, ColNum1).

calc_values(_, _, [], []).

calc_values(GameState, Player, [H | Tail], [[Value, H] | T]) :-
    move(GameState, H, NewState),
    value(NewState, Player, Value),
    calc_values(GameState, Player, Tail, T).

value(state(Board, _, _, XElim, OElim, ZElim), Player, Value) :-
    calc_value_on_board(Player, Board, 1, Value1),
    calc_value_elim(Player, XElim, OElim, ZElim, Value2),
    Value is Value1 + Value2.

calc_value_elim('X', _, O, Z, Value) :- Value is O + Z.
calc_value_elim('O', X, _, Z, Value) :- Value is X + Z.
calc_value_elim('Z', X, O, _, Value) :- Value is O + X.

calc_value_on_board(_, [], _, 0).

calc_value_on_board(Player, [Row | Rest], RowNum, Value) :-
    calc_value_on_row(Player, Row, RowNum, 1, Value1),
    RowNum1 is RowNum + 1,
    calc_value_on_board(Player, Rest, RowNum1, Value2),
    Value is Value1 + Value2.

calc_value_on_row(_, [], _, _, 0).

calc_value_on_row(Player, [Player | T], RowNum, ColNum, Value) :-
    get_value(Player, RowNum, ColNum, Value1),
    ColNum1 is ColNum + 1,
    calc_value_on_row(Player, T, RowNum, ColNum1, Value2),
    Value is Value1 + Value2.

calc_value_on_row(Player, [_ | T], RowNum, ColNum, Value) :-
    ColNum1 is ColNum + 1,
    calc_value_on_row(Player, T, RowNum, ColNum1, Value).

get_value('O', Row, Col, Value) :- 
    Aux is Col - Row,
    Value is Aux + 10.

get_value('X', _, Col, Value) :- 
    Aux is Col - 11,
    Value is 0 - Aux.

get_value('Z', Row, _, Value) :-
    Aux is Row - 10,
    Value is Aux + 10.
/* 
 ===========================================================
*/

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

execute_moves(Board, _, XEliminated, OEliminated, ZEliminated,
              [], _,
              Board, XEliminated, OEliminated, ZEliminated).

execute_moves(Board, Player, XEliminated, OEliminated, ZEliminated,
              [[Row, Col, NextRow, NextCol] | NextPos], EatMove,
              NewBoard, NewXEliminated, NewOEliminated, NewZEliminated) :-

    execute_move(EatMove, Row, Col, NextRow, NextCol, Player, 
             Board, Board1, X1Eliminated, O1Eliminated, Z1Eliminated),
    X2Eliminated is X1Eliminated + XEliminated,
    O2Eliminated is O1Eliminated + OEliminated,
    Z2Eliminated is Z1Eliminated + ZEliminated,
    execute_moves(Board1, Player, X2Eliminated, O2Eliminated, Z2Eliminated,
                  NextPos, EatMove,
                  NewBoard, NewXEliminated, NewOEliminated, NewZEliminated).

execute_move(EatMove, Row, Col, NextRow, NextCol, Player,
             Board, NewBoard, XEliminated, OEliminated, ZEliminated) :-

    remove_elem(Row, Col, Board, Board1),
    eat_elem(EatMove, Row, Col, NextRow, NextCol, 
             Board1, Board2, XEliminated, OEliminated, ZEliminated),
    insert_elem(NextRow, NextCol, Board2, NewBoard, Player).

/* 
 ===========================================================
*/

/* removes the element in the specified position */
remove_elem(Row, Col, Board, NewBoard) :-
    update_pos(Row, Col, Board, NewBoard, ' ').

/* inserts the element in the specified position */
insert_elem(Row, Col, Board, NewBoard, Player) :-
    update_pos(Row, Col, Board, NewBoard, Player).

/* In this case first argument indicates that the player didn't eta any piece */
eat_elem('n', _, _, _, _, 
        Board1, Board1, 0, 0, 0).

/* removes the element in the specified position incrementing the value of eaten peaces 
   of that specie and also changes z owner
   first argument indicates that in the movement of the player he eat a piece*/
eat_elem('y', Row, Col, NextRow, NextCol, 
        Board, NewBoard, XEliminated, OEliminated, ZEliminated) :-

    get_eat_dir(Row, Col, NextRow, NextCol, RowElem, ColElem),
    AuxRow is Row + RowElem, /* gets the row of the piece that we want to eat */
    AuxCol is Col + ColElem, /* gets the column of the piece that we want to eat */
    find_element(AuxRow, AuxCol, Board, ElementEaten),
    update_pos(AuxRow, AuxCol, Board, NewBoard, ' '),
    get_eliminated(ElementEaten, XEliminated, OEliminated, ZEliminated).

/* 
 ===========================================================
*/

/* in case of the move of the user did not eat a piece */
keep_eating('n', _, _, Board3, Board3, _, [[]]).

/* in case of the move of the user ate a piece, asks to the user to keep eating
   if the answer is no than return the values*/
keep_eating('y', Row, Col, Board, NewBoard, Player, [H | T]) :-

    repeat,
        ask_keep_eating(Answer),
        process_answer(Answer, Row, Col, NextRow, NextCol, Board, Board1, Player, H),
    keep_eating(Answer, NextRow, NextCol, Board1, NewBoard, Player, T).


process_answer('n', _, _, _, _, Board, Board, _, []) :- !.

/* in case of the move of the user ate a piece */
process_answer('y', Row, Col, NextRow, NextCol, Board, NewBoard, Player, [Row, Col, NextRow, NextCol]) :-
    display_board(Board),
    format('----------------------------------------\n\n', []),
    format('Current Row: ~p\nCurrent Column: ~p\n\n', [Row, Col]),
    ask_player_pos('Next Element', NextRow, NextCol), /* Asks the Position  where we want to move */
    verify_elem_in_pos(NextRow, NextCol, ' ', Board),
    type_of_move(Row, Col, NextRow, NextCol, Board, 'y'), !,
    format('\nValid Next Position!', []),
    execute_move('y', Row, Col, NextRow, NextCol, Player, 
             Board, NewBoard, _, _, _).

/* in case of the user doesn't insert a valid eat position */
process_answer(_, _, _, _, _, _, _, _, _) :-
    format("\nInvalid eat position", []),
    0 = 1. /* this way always returns false */