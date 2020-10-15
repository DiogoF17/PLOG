:- consult('board.pl').
:- consult('game_logic.pl').

printMenu :- 
    format('\n\n========================================\n', []),
    format('\tMAIN MENU\n', []),
    format('========================================\n', []),
    format('\n\n1) Jogar 1 vs 1;\n', []),
    format('2) Jogar 1 vs PC;\n', []),
    format('3) Jogar PC vs PC;\n', []),
    format('\nInsira a sua opcao: ', []), read(Option),
    verifyMainMenuOption(Option).

verifyMainMenuOption(Option) :-
    integer(Option), Option >= 1, Option =< 3,
    nextState(Option).

verifyMainMenuOption(_Option) :-
    format("\nOpcao Invalida! Tente novamente: ", []), read(Option1),
    verifyMainMenuOption(Option1).

nextState(Option) :-
    Option == 1,
    board(Board),
    printBoard(Board, "HUMANO VS HUMANO"),
    printPontuations(0, 0, 0),
    readNextMove.

nextState(Option) :-
    Option == 2,
    board(Board),
    printBoard(Board, "HUMANO VS PC"),
    printPontuations(0, 0, 0),
    readNextMove.

nextState(Option) :-
    Option == 3,
    board(Board),
    printBoard(Board, "PC VS PC"),
    printPontuations(0, 0, 0),
    readNextMove.

