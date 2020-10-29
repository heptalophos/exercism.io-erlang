-module(hamming).

-export([distance/2]).

-spec distance(string(),string()) -> 
      non_neg_integer() 
      | {error, string()}.
distance(Strand1, Strand2) -> 
    case (length(Strand1) =/= length(Strand2)) of 
        true -> 
            {error, "left and right strands must" 
                    ++ " be of equal length"};
        false ->
            lists:sum([1 || {N1, N2} <- 
                            lists:zip(Strand1, Strand2), 
                            N1 =/= N2])
    end.
