-module(luhn).
-author("heptalophos").

-export([valid/1]).

-spec valid(string()) -> boolean().
valid(Value) -> valid(lists:reverse(Value), 1, 0).

% Auxiliary

-spec valid(string(), integer(), integer()) -> boolean().
valid(String, Pos, CSum) ->
    case String of
        [] -> 
            case Pos == 1 orelse Pos == 2 of
                true -> false;
                false -> CSum rem 10 =:= 0
            end;
        [D|N] ->
            case D of
                $ -> valid(N, Pos, CSum);
                X -> if  
                       X >= $0 andalso X =< $9 -> 
                          valid(N, Pos + 1, CSum + adjust(D - $0, Pos));
                       true -> false
                     end
            end
    end. 

-spec adjust(pos_integer(), pos_integer()) -> pos_integer().
adjust(Digit, Position) ->
    case { Position rem 2 == 0, Digit > 4 } of
        {true, true} -> Digit * 2 - 9;
        {true, _}    -> Digit * 2;
        {_, _}       -> Digit
    end.
