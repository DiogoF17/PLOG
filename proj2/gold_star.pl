/*
plus -> +
minus -> -
mult -> *
div -> ÷
*/

/* operators_structure(Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8). */

/*
 gold_star(operators_structure(plus, minus, plus, minus, mult, plus, div, minus)).
*/

operator_to_sign(plus, +).
operator_to_sign(minus, -).
operator_to_sign(mult, *).
operator_to_sign(div, /).

list_signs(operators_structure(Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8), [Sign1, Sign2, Sign3, Sign4, Sign5, Sign6, Sign7, Sign8]) :-
    operator_to_sign(Op1, Sign1),
    operator_to_sign(Op2, Sign2),
    operator_to_sign(Op3, Sign3),
    operator_to_sign(Op4, Sign4),
    operator_to_sign(Op5, Sign5),
    operator_to_sign(Op6, Sign6),
    operator_to_sign(Op7, Sign7),
    operator_to_sign(Op8, Sign8).

print_gold_start_structure(operators_structure(Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8)) :-
    /*operator_to_sign(Op1, Sign1),
    operator_to_sign(Op2, Sign2),
    operator_to_sign(Op3, Sign3),
    operator_to_sign(Op4, Sign4),
    operator_to_sign(Op5, Sign5),
    operator_to_sign(Op6, Sign6),
    operator_to_sign(Op7, Sign7),
    operator_to_sign(Op8, Sign8),*/
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

gold_star(operators_structure(Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8)) :-
    print_gold_start_structure(operators_structure(Op1, Op2, Op3, Op4, Op5, Op6, Op7, Op8)).