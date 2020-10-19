nextState(mainMenu, Option) :-
    Option == 1,
    game_human_vs_human.

nextState(mainMenu, Option) :-
    Option == 2,
    game_human_vs_pc.

nextState(mainMenu, Option) :-
    Option == 3,
    game_pc_vs_pc.

nextState(game_h_vs_h) :-
    o_eliminated(O),
    O =:= 10.

nextState(game_h_vs_h) :-
    x_eliminated(X),
    X =:= 10.

nextState(game_h_vs_h) :-
    z_eliminated(Z),
    Z =:= 10.

nextState(game_h_vs_h) :-
    o_eliminated(O),
    z_eliminated(Z),
    x_eliminated(X),
    O =\= 10, X =\= 10, Z =\= 10,
    game_human_vs_human.
