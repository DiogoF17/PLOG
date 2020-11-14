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

play_human_vs_human(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated)) :- 
    display_game(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player),
    user_move(Board, Player, Move),
    move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),
        Move, 
        NewState),
    next_play_human_vs_human(NewState).

next_play_human_vs_human(State) :-
    game_over(State, Winner), !,
    display_end_game_menu(Winner).

next_play_human_vs_human(State) :-
    play_human_vs_human(State).

/* 
 ===========================================================
*/
/*               GameState, PC -> define as pecas que o pc controla
play_human_vs_pc(State, PC, Level) :-
    display_game(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player),
    get_move(),
    move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),
        Move, 
        NewState),
    next_play_human_vs_pc(NewState).

*/

/* 
 ===========================================================
*/

/*
play_pc_vs_pc(State, Level) :-
    display_game(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player),
    pc_move(),
    move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),
        Move, 
        NewState),
    next_play_pc_vs_pc(NewState).
*/






