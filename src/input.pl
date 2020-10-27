ask_menu_option(Option, Limit) :-
    format('\nInsira a sua opcao: ', []), read(UserInput),
    verify_menu_option(UserInput, Option, Limit).

verify_menu_option(Option, Option, Limit) :-
    integer(Option), Option >= 1, Option =< Limit.

verify_menu_option(_, Option, Limit) :-
    format("\nOpcao Invalida! Tente novamente: ", []), read(X),
    verify_menu_option(X, Option, Limit).

ask_player_move(Msg, Row, Column, Element) :-
    format('~p Row: ', [Msg]), read(InputRow),
    format('~p Column: ', [Msg]), read(InputColumn),
    valid_move(Msg, Row, Column, InputRow, InputColumn, Element).

valid_move(_, InputRow, InputColumn, InputRow, InputColumn, Element) :-
    integer(InputRow), integer(InputColumn), InputRow >= 1, InputRow =< 10, InputColumn >= 1, InputColumn =< InputRow,
    find_element(InputRow, InputColumn, Z), 
    Z == Element,
    format("\nValid Move!", []).

valid_move(Msg, Row, Column, _, _, Element) :-
    format('\nInvalid Move!\n~p Row: ', [Msg]), read(InputRow),
    format('~p Column: ', [Msg]), read(InputColumn),
    valid_move(Msg, Row, Column, InputRow, InputColumn, Element).
