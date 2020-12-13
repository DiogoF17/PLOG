/*
plus -> +
minus -> -
mult -> *
div -> ÷
*/

:- use_module(library(lists)).
:- use_module(library(clpfd)).

/* operators_structure(Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8). */

/*
 gold_star(operators_structure(plus, minus, plus, minus, mult, plus, div, minus)).
*/

print_gold_start_structure([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8]) :-
    format("        N        \n", []),
    format("       - *       \n", []),
    format("N  +  N = N  *  N\n", []),
    format(" *   =     =   - \n", []),
    format("    N       N    \n", []),
    format("     =     =     \n", []),
    format("        N        \n", []),
    format("   +         *   \n", []),
    format("     +     *     \n", []),
    format("  N           N  \n", []).

gold_star([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8]) :-
    print_gold_start_structure([Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8]).







apply_restriction(Op, N1, N2, Result):-
  Op is +,
  #=(N1+N2, Result).
apply_restriction(Op, N1, N2, Result):-
  Op is -,
  #=(N1-N2, Result).

apply_restriction(Op, N1, N2, Result):-
  Op is *,
  #=(N1*N2, Result).

apply_restriction(Op, N1, N2, Result):-
  Op is /,
  #=(N1/N2, Result).



equations(N1,O1,N2,  N3,O2,N4):-
  equations(N1, O1, N2, Result),
  equations(N3, O2, N4, Result).



solve(Operators, Numbers):-
  Numbers = [A, B, C, D, E, F, G, H, I, J],


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


  all_distinct(Numbers),
  domain(Numbers, 0, 9),
  element(1, Operators, O1),
  element(2, Operators, O2),
  element(3, Operators, O3),
  element(4, Operators, O4),
  element(5, Operators, O5),
  element(6, Operators, O6),
  element(7, Operators, O7),
  element(8, Operators, O8),
  element(9, Operators, O9),
  element(10, Operators, O10),
  equations(A,O2,D,   G,O5,J),
  equations(A,O1,C,   I, O8, F),
  equations(B,O9,F,   H,O6, J),
  equations(B,O10,C,  D,O3, E),
  equations(G,O4,E,   I,O7, H),


  
