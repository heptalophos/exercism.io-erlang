-module(strain).

-export([keep/2, discard/2]).

-spec keep(fun(), list()) -> list().
keep(Fn, List) ->
  [ X || X <- List, Fn(X) ].

-spec discard(fun(), list()) -> list().
discard(Fn, List) ->
  [ X || X <- List, not Fn(X) ].

