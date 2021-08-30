-module(collatz_conjecture).

-export([steps/1]).

-spec steps(integer()) -> non_neg_integer() | error.
steps(N) when 
         is_integer(N) andalso N > 0 -> steps(N, 0);
steps(_) -> error(badarg).

-spec steps(N::integer(), Step::non_neg_integer()) -> 
                                    non_neg_integer().
steps(1, Step) -> Step;
steps(N, Step) when 
               N rem 2 =:= 0 -> steps(N div 2, Step + 1);
steps(N, Step) -> steps(3 * N + 1, Step + 1).
