-module(queen_attack).

-export([can_attack/2]).

-spec can_attack({0..7, 0..7}, {0..7, 0..7}) -> 
                 boolean() | error.

can_attack(WhiteQueen, BlackQueen) -> 
    {WX, WY} = WhiteQueen,
    {BX, BY} = BlackQueen,
    OffBoard = fun(X) -> 
        if 
            X < 0 orelse X > 7 -> true;
            true -> false 
        end 
    end,
    case lists:any(OffBoard, [WX, WY, BX, BY]) of  
        true  -> 
            error(invalid_position);
        false -> 
            case ({abs(WX - BX), abs(WY - BY)}) of 
                {0, 0} -> error(on_same_square);
                {_, 0} -> true;
                {0, _} -> true;
                {X, Y} -> X == Y 
            end
    end.

