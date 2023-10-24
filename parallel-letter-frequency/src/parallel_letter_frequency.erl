-module(parallel_letter_frequency).

-export([dict/1, freq/1]).

-spec dict([string()]) -> dict:dict(char(), pos_integer()).
dict(Strings) ->
    lists:foldl(fun(D, Acc) -> dict:merge(fun (_, A, B) -> A + B end, D, Acc)
                end, dict:new(), rpc:pmap({?MODULE, freq}, [], Strings)).

-spec freq(string()) -> dict:dict(char(), pos_integer()).
freq(String) -> 
    lists:foldl(fun (L, Acc) -> dict:update_counter(L, 1, Acc) 
                end, dict:new(), String).
