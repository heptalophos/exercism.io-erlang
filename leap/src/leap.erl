-module(leap).

-export([leap_year/1]).

-spec leap_year(pos_integer()) -> boolean().

leap_year(Y) when Y rem 400 =:= 0 -> 
    true;
leap_year(Y) when Y rem 100 =:= 0 -> 
    false;
leap_year(Y) when Y rem   4 =:= 0 -> 
    true;
leap_year(_) -> 
    false.
