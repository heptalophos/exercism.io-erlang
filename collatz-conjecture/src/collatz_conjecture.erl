-module(collatz_conjecture).

-export([steps/1]).

-spec steps(pos_integer()) -> pos_integer() | {error, string()}.
steps(1) -> 0;
steps(N) when N =< 0 orelse not is_integer(N) -> 
    {error, "Only positive numbers are allowed"};
steps(N) when N rem 2 =:= 0 -> steps(N div 2) + 1;
steps(N) -> steps(3 * N + 1) + 1.
