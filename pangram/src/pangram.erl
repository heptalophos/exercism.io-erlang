-module(pangram).

-export([is_pangram/1]).

-spec is_alpha(char()) -> boolean().
is_alpha(C) when C >= $a andalso C =< $z -> true;
is_alpha(_) -> false.

-spec is_pangram(string()) -> boolean().
is_pangram(Sentence) -> 
    sets:size(
        sets:from_list(
            lists:filter(
                fun(X) -> is_alpha(X) end, 
                string:casefold(Sentence)
            )
        )
    ) =:= length(lists:seq($a,$z)).