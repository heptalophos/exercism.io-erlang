-module(queen_attack).

-export([can_attack/2]).

-spec can_attack({0..7, 0..7}, {0..7, 0..7}) -> boolean() | {error, atom()}.

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
        true  -> %% any queen @ illegal rank or file
            {error, invalid_position_offboard};
        false -> %% both queens @ legal rank & file
            case ({abs(WX - BX), abs(WY - BY)}) of 
                %% both queens @ same square
                {0, 0} -> {error, invalid_position_same};
                %% both queens @ same file
                {_, 0} -> true; 
                %% both queens @ same rank
                {0, _} -> true; 
                %% queens @ same diagonal
                {X, Y} when X =:= Y -> true;
                %% otherwise
                {_, _} -> false
            end
    end.

