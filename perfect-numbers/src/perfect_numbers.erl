-module(perfect_numbers).

-export([classify/1]).

-type nicomachusclass() :: perfect | abundant | deficient.

-spec classify(pos_integer()) -> nicomachusclass() | error.
classify(Number) ->
    case Number > 0 of
        true -> Factors = [Factor || Factor <-  lists:seq(1, Number div 2), 
                                                Number rem Factor == 0],
                AliquotSum = lists:sum(Factors),
                if 
                    AliquotSum >  Number -> abundant;
                    AliquotSum == Number -> perfect;
                    AliquotSum <  Number -> deficient
                end;
        _ -> error("Not a positive integer")
    end.
