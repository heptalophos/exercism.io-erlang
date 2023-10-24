-module(diamond).

-export([rows/1]).

-spec rows([$A..$Z]) -> [[$A..$Z | $ ], ...].
rows ([Letter]) -> diamond (Letter, 0, 2 * (Letter - $A) - 1, []).

%% Auxiliary functions

-spec spaces(non_neg_integer()) -> [$ ,...].
spaces (N) -> 
    case N of
        0 -> "";
        _ -> [" " || _ <- lists:seq(1, N) ]
    end.

-spec row([$A..$Z], integer(), integer()) -> [[$A..$Z | $ ],...].
row(Letter, Outside, Middle) ->
    case Middle > 0 of
        true -> lists:flatten ([spaces (Outside), Letter, spaces (Middle), 
                                Letter, spaces (Outside)]);
        _ -> lists:flatten ([spaces (Outside), Letter, spaces (Outside)])
    end.

-spec diamond([$A..$Z],integer(),integer(),[[$A..$Z | $ ],...]) -> [[$A..$Z | $ ],...].
diamond (Letter, Outside, Middle, Acc) ->
    case Middle < 1 of 
        true -> Upper     = [row(Letter, Outside, Middle) | Acc],
                [_|Lower] = lists:reverse(Upper),
                Upper ++ Lower;
        _ -> diamond (Letter - 1, Outside + 1, Middle - 2, 
                      [row(Letter, Outside, Middle) | Acc])
    end.
