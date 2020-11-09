/* takes the current state and produces a new one according to the move*/
make_move(state(Board, Player, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated), 
          state(NewBoard, NewPlayer, New_Player_Has_Z, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated)) :-
    read_move(CurRow, CurCol, NextRow, NextCol, Board, Player, Eat),
    execute_move(Eat, CurRow, CurCol, NextRow, NextCol, Player, 
             Board, X_Eliminated, O_Eliminated, Z_Eliminated,
             Board1, X1_Eliminated, O1_Eliminated, Z1_Eliminated),
    keep_eating(Eat, NextRow, NextCol, Board1, NewBoard, Player,
                X1_Eliminated, O1_Eliminated, Z1_Eliminated,
                New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated),
    change_Player_Has_Z(Eat, Player, Player_Has_Z, New_Player_Has_Z),
    next_player(Player, Player_Has_Z, New_Player_Has_Z, NewPlayer).

/* ---------------------------------------------------------------- */
/*                          MOVES                                   */
/* ---------------------------------------------------------------- */

execute_move(Eat, CurRow, CurCol, NextRow, NextCol, Player,
             Board, X_Eliminated, O_Eliminated, Z_Eliminated,
             NewBoard, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated) :-

    remove_elem(CurRow, CurCol, Board, Board1),
    eat_elem(Eat, CurRow, CurCol, NextRow, NextCol, 
             Board1, X_Eliminated, O_Eliminated, Z_Eliminated,
             Board2, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated),
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
        Board1, X_Eliminated, O_Eliminated, Z_Eliminated,
        Board1, X_Eliminated, O_Eliminated, Z_Eliminated).

/* removes the element in the specified position incrementing the value of eaten peaces 
   of that specie and also changes z owner
   first argument indicates that in the movement of the player he eat a piece*/
eat_elem('y', CurRow, CurCol, NextRow, NextCol, 
        Board1, X_Eliminated, O_Eliminated, Z_Eliminated,
        Board2, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated) :-

    get_eat_dir(CurRow, CurCol, NextRow, NextCol, RowElem, ColElem),
    AuxRow is CurRow + RowElem, /* gets the row of the piece that we want to eat */
    AuxCol is CurCol + ColElem, /* gets the column of the piece that we want to eat */
    find_element(AuxRow, AuxCol, Board1, Z),
    update_pos(AuxRow, AuxCol, Board1, Board2, ' '),
    inc_eliminated(Z, X_Eliminated, O_Eliminated, Z_Eliminated, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated).

/* ------------------- */

/* in case of the move of the user did not eat a piece */
keep_eating('n', _, _, Board3, Board3, _,
            X1_Eliminated, O1_Eliminated, Z1_Eliminated,
            X1_Eliminated, O1_Eliminated, Z1_Eliminated).

/* in case of the move of the user ate a piece, asks to the user to keep eating
   if the answer is no than return the values*/
keep_eating('y', CurRow, CurCol, Board3, NewBoard, Player,
            X1_Eliminated, O1_Eliminated, Z1_Eliminated,
            New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated) :-

    repeat,
        ask_keep_eating(Answer),
        process_answer(Answer, CurRow, CurCol, NextRow, NextCol, Board3, Board4, Player,
                        X1_Eliminated, O1_Eliminated, Z1_Eliminated,
                        X2_Eliminated, O2_Eliminated, Z2_Eliminated),
    keep_eating(Answer, NextRow, NextCol, Board4, NewBoard, Player,
        X2_Eliminated, O2_Eliminated, Z2_Eliminated,
        New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated).

/* ------------------- */

process_answer('n', _, _, _, _, Board, Board, _,
            X_Eliminated, O_Eliminated, Z_Eliminated,
            X_Eliminated, O_Eliminated, Z_Eliminated) :- !.

/* in case of the move of the user ate a piece */
process_answer('y', CurRow, CurCol, NextRow, NextCol, Board, NewBoard, Player,
            X_Eliminated, O_Eliminated, Z_Eliminated,
            New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated) :-
    display_game(Board, Player),
    format('----------------------------------------\n\n', []),
    format('Current Row: ~p\nCurrent Column: ~p\n\n', [CurRow, CurCol]),
    ask_player_pos('Next Element', NextRow, NextCol), /* Asks the Position  where we want to move */
    can_eat(NextRow, NextCol, CurRow, CurCol, Board), !,
    format('\nValid Next Position!', []),
    execute_move('y', CurRow, CurCol, NextRow, NextCol, Player, 
             Board, X_Eliminated, O_Eliminated, Z_Eliminated,
             NewBoard, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated).

/* in case of the user doesn't insert a valid eat position */
process_answer(_, _, _, _, _, _, _, _,
               _, _, _, _, _, _) :-
    format("\nInvalid eat position", []),
    0 = 1. /* this way always returns false */

/* ---------------------------------------------------------------- */

inc_eliminated('X', X_Eliminated, Y_Eliminated, Z_Eliminated, New_X_Eliminated, Y_Eliminated, Z_Eliminated) :-
    New_X_Eliminated is X_Eliminated + 1.

inc_eliminated('O', X_Eliminated, O_Eliminated, Z_Eliminated, X_Eliminated, New_O_Eliminated, Z_Eliminated) :-
    New_O_Eliminated is O_Eliminated + 1.

inc_eliminated('Z', X_Eliminated, Y_Eliminated, Z_Eliminated, X_Eliminated, Y_Eliminated, New_Z_Eliminated) :-
    New_Z_Eliminated is Z_Eliminated + 1.

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