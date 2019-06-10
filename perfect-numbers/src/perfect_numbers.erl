-module(perfect_numbers).

-export([classify/1]).

-type nicomachusclass() :: perfect | abundant | deficient.

-spec classify(pos_integer()) -> nicomachusclass() | error.
classify(Number) when Number > 0 ->
    Factors = [Factor || Factor <- lists:seq(1, Number div 2), 
                                   Number rem Factor == 0],
    Aliquot = lists:sum(Factors),
    if 
        Aliquot >  Number -> abundant;
        Aliquot == Number -> perfect;
        Aliquot <  Number -> deficient
    end;
classify(_) -> 
    error("Not a natural number").
