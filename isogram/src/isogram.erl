-module(isogram).

-export([is_isogram/1]).

-spec is_isogram([char(),...]) -> boolean().
is_isogram(Phrase) -> 
    Cs = [C || C <- string:to_lower(Phrase), 
                    $a =< C, C =< $z],
    has_duplicates(lists:sort(Cs)) == false.

-spec has_duplicates([any()]) -> boolean().
has_duplicates([X, Y | _]) when X =:= Y -> 
        true;
has_duplicates([_ | Rest]) -> 
        has_duplicates(Rest);
has_duplicates([]) -> 
        false.
