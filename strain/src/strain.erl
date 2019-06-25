-module(strain).

-export([keep/2, discard/2]).

-spec keep(fun(), list()) -> list().
keep(Fn, List) ->
  lists:filter(fun(X) -> Fn(X) end, List).

-spec discard(fun(), list()) -> list().
discard(Fn, List) ->
  lists:filter(fun(X) -> not Fn(X) end, List).

