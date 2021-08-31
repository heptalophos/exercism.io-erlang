-module(collatz_conjecture).

-export([steps/1]).

-spec steps(integer()) -> non_neg_integer() | error.
steps(N) ->
    case is_integer(N) andalso N > 0 of
        true -> 
            steps(N, 0);
        _ -> 
            error(badarg)
    end.


%Auxiliary

-spec steps(N::integer(), 
            Step::non_neg_integer()) -> 
                                non_neg_integer().
steps(N, Step) -> 
    case N of 
        1 -> Step;
        _ -> 
            case N rem 2 =:= 0 of 
                true -> steps(N div 2, Step + 1);
                _ -> steps(3 * N + 1, Step + 1)
            end
    end.
