-module(difference_of_squares).

-export([ difference_of_squares/1, 
          square_of_sum/1, 
          sum_of_squares/1 ]).

-spec square(integer()) -> integer().
square(X) -> X * X.

-spec square_of_sum(integer()) -> integer(). 
square_of_sum(Number) -> 
    square (lists:foldl (fun (X, Sum) -> X + Sum end, 
                         0, 
                        lists:seq(1, Number))).

-spec sum_of_squares(integer()) -> integer(). 
sum_of_squares(Number) -> 
    lists:foldl (fun (X, Sum) -> square(X) + Sum end, 
                 0, lists:seq(1, Number)).

-spec difference_of_squares(integer()) -> integer(). 
difference_of_squares(Number) -> 
    square_of_sum(Number) - sum_of_squares(Number).
