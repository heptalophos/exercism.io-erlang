-module(atbash_cipher).

-export([decode/1, encode/1]).

-spec decode(string()) -> string().
decode(Phrase) -> 
    lists:filtermap(fun revert/1, 
                    string:lowercase(Phrase)).

-spec encode(string()) -> string().
encode(Phrase) -> 
     chunks(5, decode(Phrase)).

% auxiliary

-spec revert(char()) -> {true, char()} | false. 
revert(C) -> 
    case (C >= $a) and ($z >= C) of
        true  -> 
            {true, ($z - C) + $a};
        false -> 
            case (C >= $0) and ($9 >= C) of
                true -> {true, C};
                false -> false
            end
    end.

-spec chunks(pos_integer(), string()) -> string().
chunks(N, S) ->
    case (N >= length(S)) of 
        true -> 
            S;
        false -> 
            {H, Rest} = lists:split(N, S),
            H ++ " " ++ chunks(N, Rest)
    end.