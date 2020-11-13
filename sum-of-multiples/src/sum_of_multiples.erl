-module(sum_of_multiples).

-export([sum/2]).

-spec sum(Factors::[non_neg_integer()], 
          Limit::pos_integer()) -> 
                      non_neg_integer().

sum(Factors, Limit) -> 
    lists:foldl(fun (M, Sum) -> 
                Sum + M end, 
                0, 
                [X || X <- lists:seq(0, Limit - 1),
                 lists:any(fun (M) -> 
                                if
                                  X rem M =:= 0 -> true;
                                  X =:= 0 -> true;
                                  true -> false 
                                end
                           end,
                 Factors)]
               ).
