-module(sum_of_multiples).

-export([sum/2]).

-spec sum([non_neg_integer()], pos_integer()) -> non_neg_integer().
sum(Factors, Limit) -> 
    lists:foldr(fun (M, Sum) -> Sum + M end, 0, 
                [X || X <- lists:seq(1, Limit - 1),
                 lists:any(fun (M) -> X rem M =:= 0 end, 
                 Factors)]
               ).
