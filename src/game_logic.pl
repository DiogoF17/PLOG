/* takes the current state and produces a new one according to the move*/
make_move(state(Board, Player, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated), 
          state(NewBoard, NewPlayer, New_Player_Has_Z, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated)) :-

    read_next_move(CurRow, CurCol, NextRow, NextCol, Board, Player, Eat),
    remove_elem(CurRow, CurCol, Board, Board1),
    eat_elem(Eat, CurRow, CurCol, NextRow, NextCol, 
             Board1, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated,
             Board2, New_Player_Has_Z, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated),
    insert_elem(NextRow, NextCol, Board2, NewBoard, Player),
    next_player(Player, NewPlayer, New_Player_Has_Z).

/* removes the element in the specified position */
remove_elem(Row, Col, Board, NewBoard) :-
    update_pos(Row, Col, Board, NewBoard, ' ').

/* inserts the element in the specified position */
insert_elem(Row, Col, Board, NewBoard, Player) :-
    update_pos(Row, Col, Board, NewBoard, Player).

/* In this case first argument indicates that the player didn't eta any piece */
eat_elem(0, _, _, _, _, 
        Board1, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated,
        Board1, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated).

/* removes the element in the specified position incrementing the value of eaten peaces 
   of that specie and also changes z owner
   first argument indicates that in the movement of the player he eat a piece*/
eat_elem(1, CurRow, CurCol, NextRow, NextCol, 
        Board1, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated,
        Board2, New_Player_Has_Z, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated) :-

        get_eat_dir(CurRow, CurCol, NextRow, NextCol, RowElem, ColElem),
        AuxRow is CurRow + RowElem, /* gets the row of the piece that we want to eat */
        AuxCol is CurCol + ColElem, /* gets the column of the piece that we want to eat */
        find_element(AuxRow, AuxCol, Board1, Z),
        update_pos(AuxRow, AuxCol, Board1, Board2, ' '),
        inc_eliminated(Z, X_Eliminated, O_Eliminated, Z_Eliminated, New_X_Eliminated, New_O_Eliminated, New_Z_Eliminated),
        change_z_owner(Player_Has_Z, New_Player_Has_Z).

inc_eliminated('X', X_Eliminated, Y_Eliminated, Z_Eliminated, New_X_Eliminated, Y_Eliminated, Z_Eliminated) :-
    New_X_Eliminated is X_Eliminated + 1.

inc_eliminated('O', X_Eliminated, O_Eliminated, Z_Eliminated, X_Eliminated, New_O_Eliminated, Z_Eliminated) :-
    New_O_Eliminated is O_Eliminated + 1.

inc_eliminated('Z', X_Eliminated, Y_Eliminated, Z_Eliminated, X_Eliminated, Y_Eliminated, New_Z_Eliminated) :-
    New_Z_Eliminated is Z_Eliminated + 1.

change_z_owner('O', 'X').
change_z_owner('X', 'O').


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