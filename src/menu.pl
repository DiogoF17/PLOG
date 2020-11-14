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

menu_select_piece(Piece) :-
    display_menu_select_piece,
    ask_menu_option(Piece, 2).

display_menu_select_piece :- 
    format('\n========================================\n', []),
    format('\tSELECT PC PIECE\n', []),
    format('========================================\n', []),
    format('\n\n1) O;\n', []),
    format('2) X;\n', []).

menu_select_difficulty(Difficulty) :-
    display_menu_select_difficulty,
    ask_menu_option(Difficulty, 3).

display_menu_select_difficulty :- 
    format('\n========================================\n', []),
    format('\tSELECT DIFICULTY\n', []),
    format('========================================\n', []),
    format('\n\n1) Easy;\n', []),
    format('2) Medium;\n', []),
    format('3) Hard;\n', []).

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
