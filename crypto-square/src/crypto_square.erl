-module(crypto_square).

-export([ciphertext/1]).

-type cleanstring() :: [$ |$a..$z|$0..$9].

-spec ciphertext(string()) -> cleanstring().
ciphertext(PlainText) -> 
    Text = PlainText,
    case Text of
        [] -> "";
        _  -> Normal = normalized(PlainText),
              Square = split(Normal, ceil(math:sqrt(length(Normal)))),
              lists:append(lists:join(" ", transpose(Square)))
    end.

% Auxiliary

-spec is_alphanumeric(char()) -> boolean().
is_alphanumeric(C) ->
    if 
        $9 >= C andalso C >= $0 -> true;
        $z >= C andalso C >= $a -> true;
        true -> false
    end.

-spec is_empty(list()) -> boolean().
is_empty(Ls) -> lists:all(fun(L) -> L =:= [] end, Ls).

-spec normalized(string()) -> cleanstring().
normalized(String) -> [C || C <- string:lowercase(String), is_alphanumeric(C)].

-spec split(string(), pos_integer()) -> [string()].
split(Text, Lines) ->
    case Lines >= length(Text) of
        true -> [Text ++ lists:duplicate(Lines - length(Text), $ )];
        _ -> {Line, Rest} = lists:split(Lines, Text),
             [Line | split(Rest, Lines)]
    end.

-spec transpose([string()]) -> [string()].
transpose(M) -> 
    Hs = [H || [H | _] <- M],
    Ts = [T || [_ | T] <- M],
    case not lists:all(fun is_empty/1, Ts) of
        true -> [Hs | transpose(Ts)];
        _ ->    [Hs] %% stop
    end.   