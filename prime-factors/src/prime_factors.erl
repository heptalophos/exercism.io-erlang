-module(prime_factors).

-export([factors/1]).


-spec factors(pos_integer()) -> [pos_integer()] | {error, atom()}.
factors(Value) ->
    case Value > 0 of
        true -> factors(Value, 2);
        _    -> {error, invalid_argument} 
    end.

% Auxiliary

-spec factors(pos_integer(), pos_integer()) -> [pos_integer()].
factors(V, F) ->
    case V =:= 1 of
        true -> [];
        _    -> if 
                    V rem F =:= 0 -> [F] ++ factors(V div F, F);
                    true -> factors(V, F + 1)
                end
    end.
