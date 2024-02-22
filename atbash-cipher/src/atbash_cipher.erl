-module(atbash_cipher).

-export([decode/1, encode/1]).


-spec decode(string()) -> string().
decode(Phrase) -> lists:filtermap(fun atbash/1, string:lowercase(Phrase)).

-spec encode(string()) -> string().
encode(Phrase) -> chunks(5, decode(Phrase)).

% Auxiliary

-spec atbash(char()) -> {true, char()} | false. 
atbash(C) -> 
    case (C >= $a) andalso ($z >= C) of
        true  -> {true, ($z - C) + $a};
        false -> if 
                    (C >= $0) andalso ($9 >= C) -> 
                        {true, C};
                    true -> 
                        false
                 end
    end.

-spec chunks(pos_integer(), string()) -> string().
chunks(N, S) ->
    case (N >= length(S)) of 
        true -> 
            S;
        _ -> 
            {H, Rest} = lists:split(N, S), H ++ " " ++ chunks(N, Rest)
    end.