:- use_module(library(lists)).
:- use_module(library(clpfd)).

% ############################
%         GOLD STAR
% ############################
%            A
%           - *
%    B  +  C = D  *  E
%     *   =     =   -
%        F       G
%         =     =
%            H
%       +         *
%         +     *
%      I           J

% ##################

print_gold_start_structure([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10]) :-
    format("        N        \n", []),
    format("       ~p ~p       \n", [Op1, Op2]),
    format("  N ~p N = N ~p N\n", [Op3, Op4]),
    format("   ~p =     = ~p \n", [Op5, Op6]),
    format("     N     N    \n", []),
    format("      =   =     \n", []),
    format("        N        \n", []),
    format("   ~p         ~p   \n", [Op7, Op8]),
    format("     ~p     ~p     \n", [Op9, Op10]),
    format("  N           N  \n", []).

print_gold_start_completed([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10], [N1, N2, N3, N4, N5, N6, N7, N8, N9, N10]) :-
    format("        ~p        \n", [N1]),
    format("       ~p ~p       \n", [Op1, Op2]),
    format("  ~p ~p ~p = ~p ~p ~p\n", [N2, Op3, N3, N4, Op4, N5]),
    format("   ~p =     = ~p \n", [Op5, Op6]),
    format("     ~p     ~p    \n", [N6, N7]),
    format("      =   =     \n", []),
    format("        ~p        \n", [N8]),
    format("   ~p         ~p   \n", [Op7, Op8]),
    format("     ~p     ~p     \n", [Op9, Op10]),
    format("  ~p           ~p  \n", [N9, N10]).

% ##################

% Calculates the values of star. 
% Ops -> list of operands in star 
% gold_star(+Ops).

% ##################

gold_star([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10]) :-
    %
    statistics(runtime, _),
    % prints gold star structure
    format("---------------\n", []),
    format("GOLD STAR STRUCTURE\n\n", []),
    print_gold_start_structure([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10]),
    %
    % there is 10 numbers in star
    Num = [N1, N2, N3, N4, N5, N6, N7, N8, N9, N10],
    % numbers can only vary between 0 and 9
    domain(Num, 0, 9),
    %
    format("---------------\n", []),
    format("Putting Restrictions...\n\n", []),
    % all numbers are distinct
    all_distinct(Num),
    % each line represents a equation
    format("N2 ", []), calc(N2, N3, Op3, Res1), format(" N3 = N4 ", []), calc(N4, N5, Op4, Res1), format(" N5\n", []),
    format("N3 ", []), calc(N3, N1, Op1, Res2), format(" N1 = N9 ", []), calc(N9, N6, Op7, Res2), format(" N6\n", []),
    format("N1 ", []), calc(N1, N4, Op2, Res3), format(" N4 = N7 ", []), calc(N7, N10, Op8, Res3), format(" N10\n", []),
    format("N2 ", []), calc(N2, N6, Op5, Res4), format(" N6 = N8 ", []), calc(N8, N10, Op10, Res4), format(" N10\n", []),
    format("N7 ", []), calc(N7, N5, Op6, Res5), format(" N5 = N9 ", []), calc(N9, N8, Op9, Res5), format(" N8\n", []),
    statistics(runtime, [_, T]),
    format("\nDone! Time: ~p\n", [T]),
    %
    format("---------------\n", []),
    format("Labeling...\n", []),
    labeling([], Num),
    statistics(runtime, [_, T1]),
    format("\nDone! Time: ~p\n", [T1]),
    %
    % prints gold star completed
    format("---------------\n", []),
    format("GOLD STAR COMPLETED\n\n", []),
    print_gold_start_completed([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8, Op9, Op10], [N1, N2, N3, N4, N5, N6, N7, N8, N9, N10]),
    format("---------------\n\n", []).

% ##################

% Executes a calculation of two numbers.
% N1 -> first operand
% N2 -> second operand
% Op -> operator
% Res -> saves the result
% calc(+N1, +N2, +Op, -Res).

% ##################

% Executes the sum of two numbers
calc(N1, N2, +, Res) :-
    format("+", []),
    Res #= N1 + N2.

% Executes the subtraction of two numbers
calc(N1, N2, -, Res) :-
    format("-", []),
    Res #= N1 - N2.

% Executes the multiplication of two numbers
calc(N1, N2, *, Res) :-
    format("*", []),
    Res #= N1 * N2.

% Executes the division of two numbers, 
% making sure that the second operand is not 0
% and also making sure that the rest of the division of N1 for N2 is 0
calc(N1, N2, /, Res) :-
    format("/", []),
    N2 #\= 0,
    N1 mod N2 #= 0,
    Res #= N1 / N2.

% ##############################################
%                    TESTES
% ##############################################

% 1) gold_star([-, *, +, *, *, -, +, *, +, *]).
% 2) gold_star([+, *, *, +, -, *, +, +, +, /]).
% 3) gold_star([+, +, *, +, +, -, +, *, /, +]).
% 4) gold_star([+, +, +, *, *, +, *, +, +, +]).
% 5) gold_star([+, +, +, /, *, +, +, *, *, +]).
% 6) gold_star([+, +, +, +, +, *, +, +, +, *]).
% 7) gold_star([+, -, +, *, +, +, -, /, +, /]).
% 8) gold_star([/, *, +, +, +, -, -, +, /, +]).
% 9) gold_star([+, +, +, +, -, -, /, -, /, +]).
% 10) gold_star([+, +, /, +, +, /, +, +, -, *]).



  
