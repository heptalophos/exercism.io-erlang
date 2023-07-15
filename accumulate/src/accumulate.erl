-module(accumulate).
-author(heptalophos).

-export([accumulate/2]).

-spec accumulate(fun((A) -> B), list(A)) -> list(B).
accumulate(Function, List) -> accumulate(Function, List, []).

% Auxiliary fcns

-spec accumulate(fun((A) -> B), list(A), list(B)) -> list(B).
accumulate(Function, List, Accumulator) ->
    case List of 
        []    -> reverse(Accumulator);
        [H|T] -> accumulate(Function, T, [Function(H)|Accumulator])
    end.

-spec reverse(list(A)) -> list(A).
reverse(List) -> reverse(List, []).

-spec reverse(list(A), list(A)) -> list(A).
reverse(List, Reversed) -> 
    case List of 
        []    -> Reversed;
        [H|T] -> reverse(T, [H|Reversed])
    end.