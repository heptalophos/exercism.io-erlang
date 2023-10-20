-module(darts).

-export([score/2]).

-spec score(number(), number()) -> integer().
score(X, Y) -> 
    Radius = math:sqrt(math:pow(X, 2) + math:pow(Y, 2)),
    if 
        Radius =< 1 -> 10;
        Radius =< 5 -> 5;
        Radius =< 10 ->1;
        true -> 0
    end.
