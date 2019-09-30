-module(run_length_encoding).

-export([decode/1, encode/1]).

-type plain() :: [$A..$Z | $a..$z ].
-type encoded() :: [$A..$Z | $a..$z | $0..$9].

-spec decode(encoded()) -> plain().
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

-spec encode(plain()) -> encoded().
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

% Auxiliary

-spec decode_group(char(), [char()]) -> [char()].
decode_group(L, N) -> 
    if 
        N =/= [] -> lists:duplicate(list_to_integer(N), L);
        true -> [L]
    end.

-spec encode_group(char(), non_neg_integer()) -> [char()].
encode_group(L, N) -> 
    if 
        N =/= 1 -> integer_to_list(N) ++ [L];
        true -> [L]
    end.