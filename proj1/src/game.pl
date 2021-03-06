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

/* 
 ===========================================================
*/

play(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), PC, Level) :- 
    display_game(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player),
    get_move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),
            PC, Level, Move),
    move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),
        Move, 
        NewState),
    next_play(NewState, PC, Level).

next_play(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), _, _) :-
    game_over(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Winner), !,
    format("\n========================================\n\tFINAL BOARD\n========================================\n", []),
    display_board(Board),
    display_end_game_menu(Winner).

next_play(State, PC, Level) :-
    play(State, PC, Level).





