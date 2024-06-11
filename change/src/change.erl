-module(change).

-export([find_fewest_coins/2]).

-spec find_fewest_coins(pos_integer(), [pos_integer()]) -> [pos_integer()].
% find_fewest_coins(_Target, _Coins) -> .
find_fewest_coins(0, _) -> [];
find_fewest_coins(Target, _) when Target < 0 -> error(undefined);
find_fewest_coins(Target, Coins) -> 
    SortDenominations = lists:sort(fun (X, Y) -> X > Y end, Coins),
    case Target < lists:min(Coins) of
        true -> undefined;
        _ -> find_fewest_coins(Target, SortDenominations, [])
    end.

#