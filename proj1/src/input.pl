ask_menu_option(Option, Limit) :-
    format('\nOption: ', []), read(UserInput),
    verify_menu_option(UserInput, Option, Limit).

verify_menu_option(Option, Option, Limit) :-
    integer(Option), Option >= 1, Option =< Limit.

verify_menu_option(_, Option, Limit) :-
    format("\nInvalid Option! Try again: ", []), read(X),
    verify_menu_option(X, Option, Limit).

ask_keep_eating(Answer) :-
    format('\n\nKeep Eating(y/n): ', []), read(UserInput), 
    verify_answer(UserInput, Answer).

verify_answer('y', 'y') :- !.
verify_answer('n', 'n') :- !.

verify_answer(_, Answer) :-
    format("\nInvalid Answer! Try Again(y/n): ", []), read(UserInput),
    verify_answer(UserInput, Answer).

ask_user_move(Row, Col, NextRow, NextCol, Board, Element, Eat) :-
    repeat,
        ask_cur_pos(Row, Col, Board, Element),
        ask_next_pos(Row, Col, NextRow, NextCol, Board, Eat).

ask_cur_pos(Row, Col, Board, Element) :- 
    format('------------------------------\n\n', []),
    ask_player_pos('Current Element', Row, Col), /* Asks the curent Position of the element */
    valid_cur_pos(Row, Col, Board, Element).

ask_next_pos(Row, Col, NextRow, NextCol, Board, Eat) :-
    format('\n------------------------------\n\n', []),
    ask_player_pos('Next Element', NextRow, NextCol), /* Asks the Position  where we want to move */
    valid_next_pos(NextRow, NextCol, Row, Col, Board, Eat).

ask_player_pos(Msg, Row, Column) :-
    format('~p Row: ', [Msg]), read(Row),
    format('~p Column: ', [Msg]), read(Column).

valid_cur_pos(Row, Col, Board, Element) :-
    verify_elem_in_pos(Row, Col, Element, Board), !,
    format("\nValid Current Position!", []).

valid_cur_pos(_, _, _, Element) :-
    format("\nInvalid Current Position for Element: ~p\n", [Element]),
    0 = 1. /* this way always returns false */

valid_next_pos(NextRow, NextCol, Row, Col, Board, Eat) :-
    verify_elem_in_pos(NextRow, NextCol, ' ', Board),
    type_of_move(Row, Col, NextRow, NextCol, Board, Eat), !,
    format("\nValid Next Position!", []).

valid_next_pos(_, _, _, _, _, _) :-
    format("\nInvalid Next Position! \n", []),
    0 = 1. /* this way always returns false */

can_show_pc_move(Answer) :-
    format('------------------------------\n', []),
    format("Show PC move(y/n):", []), read(UserInput), 
    verify_answer(UserInput, Answer).



