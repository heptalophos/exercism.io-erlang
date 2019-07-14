-module(hamming).

-export([distance/2]).

-spec distance(string(), string()) -> non_neg_integer() | {error, string()}.
distance(Strand1, Strand2) -> 
    case (length(Strand1) =/= length(Strand2)) of 
        true -> 
            {error, "left and right strands must be of equal length"};
        false ->
            lists:foldl(fun({N1, N2}, Sum) -> 
                            case (N1 =/= N2) of
                                true  -> Sum + 1;
                                false -> Sum
                            end
                        end, 
                        0,
                        lists:zip(Strand1, Strand2))
    end.
