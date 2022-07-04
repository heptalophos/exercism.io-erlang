-module(pascals_triangle).

-export([rows/1]).


-spec rows(pos_integer()) -> [[pos_integer()]].
rows(Count) -> 
    lists:map(fun(X) -> lists:map(fun(Y) -> binomial(X - 1, Y) 
                                  end, 
                                  lists:seq(0, X - 1) ) 
              end,
              lists:seq(1, Count)).

% Auxiliary

-spec binomial(pos_integer(), pos_integer()) -> pos_integer().
binomial(N, K) -> 
    case K =:= 0 of 
        true -> 1;
        _ -> (N + 1 - K) * binomial(N, K - 1) div K
    end.
