-module(rotational_cipher).

-export([decrypt/2, encrypt/2]).

-define (MAX_ROT, 26).


-spec encrypt(string(), non_neg_integer()) -> string().
encrypt(_String, _Key) when _String =:= [] -> [];
encrypt(String, Key) ->
    [H|T] = String, 
    [rotate(H, Key) | encrypt(T, Key)].

-spec decrypt(string(), non_neg_integer()) -> string().
decrypt(String, Key) -> 
    encrypt(String, -Key rem ?MAX_ROT + ?MAX_ROT).

%  Auxiliary

-spec rotate(char(), non_neg_integer()) -> char().
rotate(C, Shift) ->
    case C of 
        X when X >= $a andalso X =< $z ->
            rotate(C, Shift, $a);
        X when X >= $A andalso X =< $Z ->
            rotate(C, Shift, $A);
        _ -> C
    end.

-spec rotate(char(), non_neg_integer(), char()) -> char().
rotate(C, Shift, Offset) ->
    (C - Offset + Shift) rem ?MAX_ROT + Offset.