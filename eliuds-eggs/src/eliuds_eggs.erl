-module(eliuds_eggs).

-export([egg_count/1]).

egg_count(Number) -> 
    case Number of
        0 -> Number;
        N -> N rem 2 + egg_count(N div 2)
    end.
