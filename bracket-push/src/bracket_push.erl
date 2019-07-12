-module(bracket_push).

-export([is_paired/1]).


-spec is_paired(string()) -> boolean().
is_paired(String) -> is_paired(String, []).


% auxiliary

-spec is_paired([char()], [char()]) -> boolean().
%% if  stack is empty - when input is empty -> true
is_paired([], Stack) -> Stack =:= [];
%% push opening bracket to stack
is_paired([Opening | Rest], Stack) when Opening =:= ${ orelse
                                        Opening =:= $[ orelse 
                                        Opening =:= $( -> 
    is_paired(Rest, [Opening | Stack]);
%% pair brackets off
is_paired([$} | Rest], [${ | Stack]) -> 
    is_paired(Rest, Stack);
is_paired([$] | Rest], [$[ | Stack]) -> 
    is_paired(Rest, Stack);
is_paired([$) | Rest], [$( | Stack]) -> 
    is_paired(Rest, Stack);
%% non-matching opening & closing brackets in stack, input
is_paired([Closing | _], _) when Closing =:= $} orelse 
                                 Closing =:= $] orelse
                                 Closing =:= $) -> 
    false;
%% throw other characters away
is_paired([_ | Rest], Stack) -> 
    is_paired(Rest, Stack).