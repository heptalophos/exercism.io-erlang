-module(nth_prime).

-export([prime/1]).


prime(_N) -> undefined.

% Aux

-spec is_prime(pos_integer()) -> boolean().
is_prime(1) -> false;
is_prime(2) -> true;
is_prime(N) -> 
    lists:all(fun(X) -> 
                N rem X =/=0 end, 
              lists:seq(2, ceil(math:sqrt(N)))).

-spec truth(boolean()) -> 1 | 0.
truth(Tval) ->
    case Tval of
        true -> 1;
        false -> 0
    end.