-module(sum_of_multiples).

-export([sum/2]).

-spec sum([non_neg_integer()], pos_integer()) -> non_neg_integer().
sum(Factors, Limit) -> 
    lists:foldl(fun (M, Sum) -> if 
                                    M =:= 0 -> Sum; 
                                    true -> Sum + M 
                                end
                end, 
                0, 
                [X || X <- lists:seq(1, Limit - 1),
                 lists:any(fun (M) -> if
                                        X =:= 0 -> true; 
                                        X rem M =:= 0 -> true;
                                        true -> false 
                                      end
                            end, 
                 Factors)]
               ).
