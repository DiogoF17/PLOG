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