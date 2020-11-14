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

play_human_vs_human(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated)) :- 
    display_game(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated), Player),
    read_move(Board, Player, Move),
    move(state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated),
        Move, 
        NewState),
    next_play_human_vs_human(NewState).

next_play_human_vs_human(State) :-
    game_over(State, Winner), !,
    display_end_game_menu(Winner).

next_play_human_vs_human(State) :-
    play_human_vs_human(State).

play_human_vs_pc.
play_pc_vs_pc.


/*
as listas mais interiores sao para posicoes caso tenha de comer pecas
LisOfMoves[[[CurRow, CurCol, Row1, Col1], [Row1, Col1, Row2, Col2], ...], [[CurRow, CurCol, Row1, Col1], [Row1, Col1, Row2, Col2], ...]]
*/






