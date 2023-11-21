-module(strain).

-export([keep/2, discard/2]).

-type pred() :: fun((any()) -> boolean()).

-spec keep(pred(), list()) -> list().
keep(Fn, List) -> [ X || X <- List, Fn(X) ].

-spec discard(pred(), list()) -> list().
discard(Fn, List) ->  NotFn = fun(X) -> not Fn(X) end,
                      keep(NotFn, List).

