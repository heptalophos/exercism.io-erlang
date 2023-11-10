-module(darts).

-export([score/2]).

-spec score(number(), number()) -> integer().
score(X, Y) -> 
    Radius = math:sqrt(math:pow(X, 2) + math:pow(Y, 2)),
    Points = 0,
    if 
        Radius =< 1 ->  Points + 1 + 4 + 5;
        Radius =< 5 ->  Points + 1 + 4;
        Radius =< 10 -> Points + 1;
        true -> Points
    end.
