-module(rotational_cipher).

-export([decrypt/2, encrypt/2]).

-define (MAX_ROT, 26).
-define (ALPHA_LOWER, lists:seq($a,$z)).
-define (ALPHA_UPPER, lists:seq($A,$Z)).


-spec encrypt(string(), non_neg_integer()) -> string().
encrypt(String, Key) ->
    case String =:= [] of
        true -> [];
        _ -> [H|T] = String, 
             [rotate(H, Key) | encrypt(T, Key)]
    end.

-spec decrypt(string(), non_neg_integer()) -> string().
decrypt(String, Key) -> 
    encrypt(String, -Key rem ?MAX_ROT + ?MAX_ROT).

%  Auxiliary

-spec rotate(char(), non_neg_integer()) -> char().
rotate(C, Shift) ->
    case {lists:member(C, ?ALPHA_LOWER),
          lists:member(C, ?ALPHA_UPPER)} of 
        {true, _} -> rotate(C, Shift, $a);
        {_, true} -> rotate(C, Shift, $A);
        {_,    _} -> C
    end.

-spec rotate(char(), non_neg_integer(), char()) -> char().
rotate(C, Shift, Offset) ->
    (C - Offset + Shift) rem ?MAX_ROT + Offset.