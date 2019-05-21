-module(grains).

-export([square/1, total/0]).


-spec square(pos_integer()) -> pos_integer() | {error, string}.
square(Square) when is_integer(Square) -> 
    case Square > 0 andalso Square < 65 of 
        true  -> 1 bsl (Square - 1);
        false -> {error, "square must be between 1 and 64"}
    end.


-spec total() -> pos_integer().
total() -> lists:sum([square(Square) || Square <- lists:seq(1, 64)]).
