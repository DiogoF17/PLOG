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

display_end_game_menu(' ') :-
    !,
    format('\n\n========================================\n', []),
    format('\tGAME OVER\n', []),
    format('========================================\n', []),
    format("THAT'S A TIE!\n", []),
    format('========================================\n', []).

display_end_game_menu(Winner) :-
    format('\n\n========================================\n', []),
    format('\tGAME OVER\n', []),
    format('========================================\n', []),
    format('CONGRATULATIONS ~p, YOU WIN!\n', [Winner]),
    format('========================================\n', []).

calcElemPontuation(Board, XEliminated, OEliminated, ZEliminated, PontX, PontO, PontZ) :-
    count_X_touching_border(Board, BorderX), 
    count_O_touching_border(Board, BorderO), 
    count_Z_touching_border(Board, BorderZ),
    PontX is (OEliminated + ZEliminated + (2 * BorderX)),
    PontO is (XEliminated + ZEliminated + (2 * BorderO)),
    PontZ is (XEliminated + OEliminated + (2 * BorderZ)).

calcWinner(PontX, PontO, PontZ, 'O') :-
    PontO > PontX, PontO > PontZ, !.

calcWinner(PontX, PontO, PontZ, 'X') :-
    PontX > PontO, PontX > PontZ, !.

calcWinner(PontX, PontO, PontZ, 'Z') :-
    PontZ > PontO, PontZ > PontX, !.

calcWinner(_, _, _, ' ').