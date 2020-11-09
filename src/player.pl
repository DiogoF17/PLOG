/* -------------------------------------- */
read_move(CurRow, CurCol, NextRow, NextCol, Board, Element, Eat) :-
    format('----------------------------------------\n', []),
    format("\tMOVE FROM PLAYER: ~p\n", [Element]),
    repeat,
        read_cur_pos(CurRow, CurCol, Board, Element),
        read_next_pos(CurRow, CurCol, NextRow, NextCol, Board, Eat).

read_cur_pos(CurRow, CurCol, Board, Element) :- 
    format('----------------------------------------\n\n', []),
    ask_player_pos('Current Element', CurRow, CurCol), /* Asks the curent Position of the element */
    valid_cur_pos(CurRow, CurCol, Board, Element).

read_next_pos(CurRow, CurCol, NextRow, NextCol, Board, Eat) :-
    format('\n----------------------------------------\n\n', []),
    ask_player_pos('Next Element', NextRow, NextCol), /* Asks the Position  where we want to move */
    valid_next_pos(NextRow, NextCol, CurRow, CurCol, Board, Eat).

/* -------------------------------------- 
           SELECTS THE NEXT PLAYER
   -------------------------------------- */ 
/*   if the move was to eat | current_player | player_that_had_z | player_that_will_have_z */
change_Player_Has_Z(_, 'O', 'X', 'X').
change_Player_Has_Z('n', 'O', 'O', 'O').
change_Player_Has_Z('y', 'O', 'O', 'X').
change_Player_Has_Z(_, 'X', 'O', 'O').
change_Player_Has_Z('n', 'X', 'X', 'X').
change_Player_Has_Z('y', 'X', 'X', 'O').
change_Player_Has_Z('y', 'Z', 'X', 'O').
change_Player_Has_Z('y', 'Z', 'O', 'X').
change_Player_Has_Z('n', 'Z', 'X', 'X').
change_Player_Has_Z('n', 'Z', 'O', 'O').

/*    current_player | player_that_had _z | player_that_has_z | new_player*/
next_player('O', _, 'X', 'X').
next_player('O', _, 'O', 'Z').
next_player('X', _, 'X', 'Z').
next_player('X', _, 'O', 'O').
next_player('Z', 'O', 'O', 'X').
next_player('Z', 'X', 'X', 'O').
next_player('Z', 'O', 'X', 'X').
next_player('Z', 'X', 'O', 'O').