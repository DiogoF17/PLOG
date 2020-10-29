:- consult('board.pl').
:- consult('player.pl').
:- consult('game.pl').
:- consult('states.pl').
:- consult('input.pl').

main_menu :-
    display_main_menu,
    ask_menu_option(Option, 3),
    next_state(mainMenu, Option).

display_main_menu :- 
    format('\n\n========================================\n', []),
    format('\tMAIN MENU\n', []),
    format('========================================\n', []),
    format('\n\n1) Jogar 1 vs 1;\n', []),
    format('2) Jogar 1 vs PC;\n', []),
    format('3) Jogar PC vs PC;\n', []).

end_game_menu :-
    o_eliminated(EliminatedO), x_eliminated(EliminatedX), z_eliminated(EliminatedZ),
    count_O_touching_border(BorderO), count_X_touching_border(BorderX), count_Z_touching_border(BorderZ),
    PontO is (EliminatedX + EliminatedZ + (2 * BorderO)),
    PontX is (EliminatedO + EliminatedZ + (2 * BorderX)),
    PontZ is (EliminatedX + EliminatedO + (2 * BorderZ)), 
    display_end_game_menu(PontO, PontX, PontZ).

/* The Os win */
display_end_game_menu(O, X, Z) :-
    O > X, O > Z, !,
    format('\n\n========================================\n', []),
    format('\tGAME OVER\n', []),
    format('========================================\n', []),
    format('CONGRATULATIONS O, YOU WIN!\n\n', []),
    format('O: ~p / X: ~p / Z: ~p\n', [O, X, Z]),
    format('========================================\n', []).

/* The Xs win */
display_end_game_menu(O, X, Z) :-
    X > O, X > Z, !,
    format('\n\n========================================\n', []),
    format('\tGAME OVER\n', []),
    format('========================================\n', []),
    format('CONGRATULATIONS X, YOU WIN!\n\n', []),
    format('O: ~p / X: ~p / Z: ~p\n', [O, X, Z]),
    format('========================================\n', []).

/* The Zs win */
display_end_game_menu(O, X, Z) :-
    Z > O, Z > X, !,
    format('\n\n========================================\n', []),
    format('\tGAME OVER\n', []),
    format('========================================\n', []),
    format('CONGRATULATIONS Z, YOU WIN!\n\n', []),
    format('O: ~p / X: ~p / Z: ~p\n', [O, X, Z]),
    format('========================================\n', []).

/* The Zs win */
display_end_game_menu(O, X, Z) :-
    format('\n\n========================================\n', []),
    format('\tGAME OVER\n', []),
    format('========================================\n', []),
    format("THAT'S A TIE!\n\n", []),
    format('O: ~p / X: ~p / Z: ~p\n', [O, X, Z]),
    format('========================================\n', []).

