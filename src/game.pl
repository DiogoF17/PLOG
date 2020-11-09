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

play :- 
    initial(InitBoard),
    assert(state(InitBoard, 'O', 'O', 0, 0, 0)),
    repeat,
        retract(state(Board, Player, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated)),
        once(display_game(Board, Player)),
        once(display_pontuations(O_Eliminated, X_Eliminated, Z_Eliminated, Player_Has_Z)),
        once(make_move(state(Board, Player, Player_Has_Z, X_Eliminated, O_Eliminated, Z_Eliminated), NewState)),
        assert(NewState),
        endOfGame(NewState),
    end_game_menu.







