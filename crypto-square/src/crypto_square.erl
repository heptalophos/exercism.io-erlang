-module(crypto_square).

-export([ciphertext/1]).

-type cleanstring :: [$ |$a..$z|$0..$9].

-spec ciphertext(string()) -> cleanstring().
ciphertext(_PlainText) -> undefined.

% Auxiliary

is_alphanumeric(C) ->
    if 
        $0 <= C andalso C <= $9 -> true;
        $a <= C andalso C <= $z -> true;
        true -> false
    end.

normalized(String) ->
    [C || C <- string:lowercase(String), is_alphanumeric(C)].
