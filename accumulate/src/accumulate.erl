-module(accumulate).

-export([accumulate/2]).

-spec accumulate(fun((A) -> B), list(A)) -> list(B).
accumulate(Fn, Ls) -> accumulate(Fn, Ls, []).

-spec accumulate(fun((A) -> B), list(A), list(B)) -> list(B).
accumulate(_, [], Acc)     -> lists:reverse(Acc);
accumulate(Fn, [H|T], Acc) -> accumulate(Fn, T, [Fn(H)|Acc]).