-module(pangram).

-export([is_pangram/1]).

-spec is_alpha(char()) -> boolean().
is_alpha(C) when C >= $a andalso C =< $z -> true;
is_alpha(_) -> false.

-spec is_pangram(string()) -> boolean().
is_pangram(Sentence) -> 
    lists:usort(
        lists:filter(fun(X) ->
                     is_alpha(X) end, 
                     string:casefold(Sentence))) =:= lists:seq($a,$z).