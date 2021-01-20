-module(accumulate).
-author(heptalophos).

-export([accumulate/2]).

-spec accumulate(fun((A) -> B), list(A)) -> 
                                    list(B).
accumulate(Fn, Ls) -> 
    accumulate(Fn, Ls, []).

-spec accumulate(fun((A) -> B), list(A), list(B)) -> 
                                            list(B).
accumulate(_, [], Acc) -> 
    reverse(Acc);
accumulate(Fn, [H|T], Acc) -> 
    accumulate(Fn, T, [Fn(H)|Acc]).

-spec reverse(list(A)) -> list(A).
reverse(Ls) -> 
    reverse(Ls, []).

-spec reverse(list(A), list(A)) -> list(A).
reverse([], Ls) -> 
    Ls;
reverse([H|T], Ls) -> 
    reverse(T, [H|Ls]).