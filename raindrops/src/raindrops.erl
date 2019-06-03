-module(raindrops).

-export([convert/1]).

-spec convert(integer()) -> string().
convert(Number) -> 
    Sounds = [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}],
    case [D || {F, D} <- Sounds, Number rem F =:= 0] of
        [] -> 
            integer_to_list(Number);
        Drops  -> 
            lists:flatten(Drops)
    end.
