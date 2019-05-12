-module(pangram2).

-export([is_pangram/1]).

-spec is_pangram(string()) -> boolean().
is_pangram(Sentence) -> 
    lists:subtract(lists:seq($a,$z), string:casefold(Sentence)) =:= [].