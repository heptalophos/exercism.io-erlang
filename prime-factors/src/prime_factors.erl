-module(prime_factors).

-export([factors/1]).


-spec factors(pos_integer()) -> 
        [pos_integer()] | {error, atom()}.
factors(Value) when Value > 0 -> 
        factors(Value, 2);
factors(_) ->  
        {error, invalid_argument}.

-spec factors(pos_integer(), pos_integer()) -> 
        [pos_integer()].
factors(1, _) -> 
        [];
factors(V, F) when V rem F =:= 0 -> 
        [F] ++ factors(V div F, F);
factors(V, F) -> 
        factors(V, F + 1).