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
