-module(run_length_encoding).

-export([decode/1, encode/1]).

decode(String) ->
    case String of
        [] -> "";
        _  -> 
            [L|R] = lists:dropwhile(fun(C) -> C >= $0 andalso C =< $9 end, String),
            Decoded = decode_group(L, 
                                   lists:takewhile(
                                       fun(C) -> C >= $0 andalso C =< $9 end, 
                                       String)),
            Decoded ++ decode(R)
    end.

encode(String) ->
    case String of
        [] -> "";
        _  ->
            [L | R] = String,
            Encoded = encode_group(L, 
                                   length([L | lists:takewhile(
                                                    fun(C) -> C == L end, 
                                                    R)])),
            Encoded ++ encode(lists:dropwhile(fun(C) -> C == L end, R))
    end.

decode_group(L, N) -> 
    if 
        N =/= [] -> lists:duplicate(list_to_integer(N), L);
        true -> [L]
    end.

encode_group(L, N) -> 
    if 
        N =/= 1 -> integer_to_list(N) ++ [L];
        true -> [L]
    end.