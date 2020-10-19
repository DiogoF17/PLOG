:- consult('board.pl').
:- consult('game_logic.pl').
:- consult('states.pl').
:- consult('input.pl').

mainMenu :-
    printMainMenu,
    askMenuOption(Option, 3),
    nextState(mainMenu, Option).

printMainMenu :- 
    format('\n\n========================================\n', []),
    format('\tMAIN MENU\n', []),
    format('========================================\n', []),
    format('\n\n1) Jogar 1 vs 1;\n', []),
    format('2) Jogar 1 vs PC;\n', []),
    format('3) Jogar PC vs PC;\n', []).