-module(change).

-export([find_fewest_coins/2]).

-spec find_fewest_coins(pos_integer(), [pos_integer()]) -> [pos_integer()].
% find_fewest_coins(_Target, _Coins) -> .
find_fewest_coins(0, _) -> [];
find_fewest_coins(Target, _) when Target < 0 -> error(undefined);
find_fewest_coins(_, []) -> error(undefined);
find_fewest_coins(Target, Coins) -> 
    case Target < lists:min(Coins) of
        true -> undefined;
        _ -> 
            Denoms = lists:sort(fun (X, Y) -> X > Y end, Coins),
            [Res|_] = 
                optimal(find_fewest_coins(Target, Denoms, [], []), []),
            Res
    end.

% Auxiliary

-spec find_fewest_coins(pos_integer(), 
                        [pos_integer()], 
                        [pos_integer()],
                        [[pos_integer()]]) -> [[pos_integer()]].
find_fewest_coins(0, _Cs, Change, Acc) -> [lists:sort(Change) | Acc];
find_fewest_coins(_T, [], _Change, _Acc) -> [];
find_fewest_coins(T, _Cs, _Change, _Acc) when T < 0 -> [];
find_fewest_coins(T, Cs = [C|Rest], Change, Acc) ->
    find_fewest_coins(T - C, Cs, [C|Change], Acc) ++
    find_fewest_coins(T, Rest, Change, Acc).

-spec optimal([pos_integer()], [pos_integer()]) -> [pos_integer()].
optimal([], []) -> [undefined];
optimal([], Result) -> Result;
optimal([H|T], []) -> 
    optimal(T,[H]);
optimal([H|T], [H2|_]) when length(H) < length(H2) -> 
    optimal(T,[H]);
optimal([H|T], Result=[H2|_]) when length(H) =:= length(H2) -> 
    optimal(T,[H|Result]);
optimal([_|T], Result) -> 
    optimal(T,Result).