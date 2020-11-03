-module(raindrops).

-export([convert/1]).

-spec convert(integer()) -> string().
convert(Number) -> 
    case [Drop || {Factor, Drop} <- [{3, "Pling"}, 
                                     {5, "Plang"}, 
                                     {7, "Plong"}], 
                  Number rem Factor =:= 0] 
    of
        [] -> 
            integer_to_list(Number);
        Ds -> 
            lists:concat(Ds)
    end.
