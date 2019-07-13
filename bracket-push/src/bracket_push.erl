-module(bracket_push).

-export([is_paired/1]).


-spec is_paired(string()) -> boolean().
is_paired(String) -> 
    BracketsOnly = lists:filter(fun(C) -> 
                                is_bracket(C) end, String),
    is_paired(BracketsOnly, []).

% auxiliary 

-spec is_bracket(char()) -> boolean().
is_bracket(C) ->
    lists:member(C, [${, $}, $[, $], $(, $)]).

-spec is_paired([char()], [char()]) -> boolean().
%% is stack empty - when input is empty ? -> true : false
is_paired([], Stack) -> Stack =:= [];
%% push opening brackets into the stack
is_paired([Opening | Rest], Stack) when Opening =:= ${ orelse
                                        Opening =:= $[ orelse 
                                        Opening =:= $( -> 
    is_paired(Rest, [Opening | Stack]);
%% match off closing brackets to opening ones in the stack 
is_paired([$} | Rest], [${ | Stack]) -> 
    is_paired(Rest, Stack);
is_paired([$] | Rest], [$[ | Stack]) -> 
    is_paired(Rest, Stack);
is_paired([$) | Rest], [$( | Stack]) -> 
    is_paired(Rest, Stack);
%% until no more matches are possible
is_paired(_, _) -> false.