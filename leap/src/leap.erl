-module(leap).

-export([leap_year/1]).

-spec leap_year(pos_integer()) -> boolean().
leap_year(Y) ->
    case Y rem 100 of
        0 -> Y rem 400 =:= 0;
        _ -> Y rem 4 =:= 0
    end.