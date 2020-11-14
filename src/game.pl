/*
state(
    Tabuleiro atual do jogo,
    Jogador que é a jogar,
    Jogador que detém o crânio, ou seja, os zombies,
    Numero de Pecas X Eliminadas,
    Numero de Pecas O Eliminadas,
    Numero de Pecas Z Eliminadas,
    ) 
*/

play_human_vs_human :- 
    initial(InitBoard),
    assert(state(InitBoard, 'O', 'O', 0, 0, 0)),
    repeat,
        retract(state(Board, Player, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated)),
        once(display_game(Board, Player)),
        once(read_move(Board, Player, Move)),
        once(move(state(Board, Player, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated),
                  Move, NewState)),
        once(display_pontuations(O_Eliminated, X_Eliminated, Z_Eliminated, Player_Has_Z)),
        assert(NewState),
        endOfGame(NewState),
    end_game_menu.

play_human_vs_pc.
play_pc_vs_pc.


/*
as listas mais interiores sao para posicoes caso tenha de comer pecas
LisOfMoves[[[CurRow, CurCol, Row1, Col1], [Row1, Col1, Row2, Col2], ...], [[CurRow, CurCol, Row1, Col1], [Row1, Col1, Row2, Col2], ...]]
*/






