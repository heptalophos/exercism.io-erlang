-module(diamond).

-export([rows/1]).


-spec spaces(non_neg_integer()) -> [$ ,...].
spaces (0) -> "";
spaces (N) -> 
    [" " || _ <- lists:seq(1, N) ].


-spec row([$A..$Z], integer(), integer()) -> 
                               [[$A..$Z | $ ],...].
row(Letter, Outside, Middle) when Middle > 0 -> 
    lists:flatten([spaces(Outside), 
                   Letter, 
                   spaces(Middle), 
                   Letter, 
                   spaces(Outside)]);
row(Letter, Outside, _) -> 
    lists:flatten([spaces(Outside), 
                   Letter, 
                   spaces(Outside)]).


-spec diamond([$A..$Z],integer(),integer(),[[$A..$Z | $ ],...]) -> 
                                           [[$A..$Z | $ ],...].
diamond(Letter, Outside, Middle, Acc) when Middle < 1 ->
        Upper = 
            [row(Letter, Outside, Middle) | Acc],
        [_|Lower] = 
            lists:reverse(Upper),
        Upper ++ Lower;
diamond(Letter, Outside, Middle, Acc) ->
    diamond(Letter - 1, 
            Outside + 1, 
            Middle - 2, 
            [row(Letter, Outside, Middle) | Acc]).


-spec rows([$A..$Z]) -> [[$A..$Z | $ ], ...].
rows([Letter]) -> 
    diamond(Letter, 0, 2 * (Letter - $A) - 1, []).