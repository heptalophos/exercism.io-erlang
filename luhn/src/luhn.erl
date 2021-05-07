-module(luhn).

-author("heptalophos").

-export([valid/1]).

-spec valid(string()) -> boolean().
valid(Value) -> 
    valid(lists:reverse(Value), 1, 0).

% Auxiliary

-spec valid(string(), pos_integer(), pos_integer()) -> boolean().
valid([], Pos, Sum) ->
    case Pos == 1 orelse Pos == 2 of
        true -> false;
        false -> Sum rem 10 =:= 0
    end;
valid([D|N], Pos, Sum) ->
    case D of
        $ -> 
            valid(N, Pos, Sum);
        X when X >= $0 andalso X =< $9 ->
            valid(N, Pos + 1, Sum + adjust(D - $0, Pos));
        _ -> false
    end. 

-spec adjust(pos_integer(), pos_integer()) -> pos_integer().
adjust(Digit, Position) ->
    case {Position rem 2 == 0, Digit * 2 > 9} of
        {true, true} -> 
            Digit * 2 - 9;
        {true, _} -> 
            Digit * 2;
        {_, _} ->
            Digit
    end.
