askMenuOption(Option, Limit) :-
    format('\nInsira a sua opcao: ', []), read(UserInput),
    verifyMenuOption(UserInput, Option, Limit).

verifyMenuOption(Option, Option, Limit) :-
    integer(Option), Option >= 1, Option =< Limit.

verifyMenuOption(_, Option, Limit) :-
    format("\nOpcao Invalida! Tente novamente: ", []), read(X),
    verifyMenuOption(X, Option, Limit).

askPlayerMove(Msg, Row, Column, Element) :-
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
