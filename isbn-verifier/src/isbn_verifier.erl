-module(isbn_verifier).

-export([is_valid/1]).

-spec is_valid(string()) -> boolean().
is_valid(Isbn) -> is_valid(Isbn, 10, 0).


% Auxiliary

-spec is_valid([char()], integer(), integer()) -> 
                boolean().
is_valid([], 0, Sum)   -> 
    Sum rem 11 =:= 0;
is_valid([$X], 1, Sum) -> 
    is_valid([], 0, Sum + 10);
is_valid(_C, I, _Sum) when I < 0 -> 
    false;
is_valid([C | Cs], I, Sum) when C >= $0 andalso 
                                C =< $9 ->
        is_valid(Cs, I - 1, Sum + (I * (C - $0)));
is_valid([_C | Cs], I, Sum)  ->
    is_valid(Cs, I, Sum);
is_valid(_C, _I, _Sum) -> 
    false.