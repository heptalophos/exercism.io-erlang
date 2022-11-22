-module(all_your_base).
-author(heptalophos).

-export([rebase/3]).

-spec rebase(Digits, IBase, OBase) -> {ok, Val} | {error, string()} 
    when Digits :: [integer()], 
         IBase :: integer(), 
         OBase :: integer(), 
         Val :: [non_neg_integer()].
rebase(Digits, InputBase, OutputBase) -> 
    if 
        InputBase < 2  -> {error, "input base must be >= 2"};
        OutputBase < 2 -> {error, "output base must be >= 2"};
        true -> 
            case lists:any(fun(D) -> D < 0 orelse D >= InputBase end, Digits) of
                true -> {error, "all digits must satisfy 0 <= d < input base"};
                _    -> {ok, digits(value(Digits, InputBase), OutputBase)}
            end
    end. 

% Auxiliary

-spec value(Digits, Base) -> Representation 
    when Base :: pos_integer(), 
         Digits :: [0..9],
         Representation :: integer().
value(Digits, Base) -> 
    lists:foldl(fun(D, V) -> D + (V * Base) end, 0, Digits).

-spec digits(integer(), pos_integer()) -> [0..9]. 
digits(N, B) -> 
    digits(N, B, []).

-spec digits(integer(), pos_integer(), [0..9]) -> [0..9].
digits(N, B, Acc) ->     
    case N of
        0 -> 
            if 
                Acc =:= [] -> [0];
                true -> Acc
            end;
        _ -> 
            digits(N div B, B, [N rem B | Acc])
    end.
