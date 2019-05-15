-module(queen_attack).

-export([can_attack/2]).

-spec can_attack({0..7, 0..7}, {0..7, 0..7}) -> 
                 boolean() | {error, atom()}.

can_attack(WhiteQueen, BlackQueen) -> 
    {WX, WY} = WhiteQueen,
    {BX, BY} = BlackQueen,
    OffBoard = fun(X) -> 
        if X < 0 orelse X > 7 -> true; 
        true -> false 
        end 
    end,
    case lists:any(OffBoard, [WX, WY, BX, BY]) of  
        true  -> %% any queen @ illegal rank or file
            {error, invalid_position_offboard};
        false -> %% both queens @ legal rank & file
            case ({abs(WX - BX), abs(WY - BY)}) of 
                {0, 0} -> %% both queens @ same square
                    {error, invalid_position_same};
                {_, 0} -> %% both queens @ same file
                    true;
                {0, _} -> %% both queens @ same rank
                    true;
                {X, Y} when X / Y == 1 -> 
                    true; %% queens @ same diagonal
                {_, _} -> 
                    false
            end
    end.

