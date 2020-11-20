get_move(state(Board, Player, _, _, _, _), 'None', _, Move) :-
    !,
    user_move(Board, Player, Move).

get_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), 'All', Level, Move) :-
    !,
    pc_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Level, Move).

get_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player, Level, Move) :-
    !,
    pc_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Level, Move).

get_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), ZPlayer, Level, Move) :-
    !,
    pc_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Level, Move).

get_move(state(Board, Player, _, _, _, _), _, _, Move) :-
    user_move(Board, Player, Move).

/* takes the current state and produces a new one according to the move*/
user_move(Board, Player, [[Row, Col, NextRow, NextCol] | Tail]) :-
    ask_user_move(Row, Col, NextRow, NextCol, Board, Player, EatMove),
    execute_move(EatMove, Row, Col, NextRow, NextCol, Player, 
             Board, Board1, _, _, _),
    keep_eating(EatMove, NextRow, NextCol, Board1, _, Player, Tail).

/*
pc_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Level, Move) :-
    choose_move(GameState, Player, Level, Move).

choose_move(Gamestate, Player, Level, Move) :-
    valid_moves(GameState, Player, ListOfMoves),
    calc_values(GameState, Player, ListOfMoves, ListMovesWithValues),
    choose_move(Gamestate, Player, Level, ListMovesWithValues, Move).

calc_values(_, _, [], []).

calc_values(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), _, [H | Tail], [H, Value | T]) :-
    move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),
        H, 
        NewState),
    value(NewState, Player, Value),
    calc_values(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), _, Tail, T).
*/

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