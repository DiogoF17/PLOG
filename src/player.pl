/* -------------------------------------- */
read_next_move(CurRow, CurCol, NextRow, NextCol, Board, Element, Eat) :-
    format('----------------------------------------\n', []),
    format("\tMOVE FROM PLAYER: ~p\n", [Element]),
    repeat,
        format('----------------------------------------\n\n', []),
        ask_player_pos('Current Element', CurRow, CurCol), /* Asks the curent Position of the element */
        once(valid_cur_pos(CurRow, CurCol, Board, Element)),
        format('\n----------------------------------------\n\n', []),
        once(ask_player_pos('Next Element', NextRow, NextCol)), /* Asks the Position  where we want to move */
        valid_next_pos(NextRow, NextCol, CurRow, CurCol, Board, Eat).

/* -------------------------------------- 
           SELECTS THE NEXT PLAYER
   -------------------------------------- */ 

next_player('O', 'Z', 'O').
next_player('X', 'Z', 'X').
next_player('X', 'O', 'O').
next_player('O', 'X', 'X').
next_player('Z', 'O', 'X').
next_player('Z', 'X', 'O').