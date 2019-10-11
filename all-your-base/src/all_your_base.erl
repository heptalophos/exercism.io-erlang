-module(all_your_base).
-export([rebase/3]).


-spec rebase(Digits, IBase, OBase) -> 
        {ok, Val} | {error, string()} 
        when 
            Digits :: [integer()], IBase :: integer(), 
            OBase :: integer(), Val :: [non_neg_integer()].
rebase(Digits, InputBase, OutputBase) -> 
    if 
        InputBase < 2 -> {error, ""};
        OutputBase < 2 -> {error, ""};
        true -> case lists:all(fun(D) -> D >= 0 andalso 
                                         D < InputBase 
                               end, 
                               Digits) of
                    true -> 
                        {ok, digits(value(Digits, InputBase), OutputBase)};
                    _    -> 
                        {error, "all digits must satisfy 0 <= d < input base"}
                end
    end. 

% Auxiliary

-spec value(Digits, Base) -> 
            Num_in_base | {error, atom()} when 
                Base :: pos_integer(),
                Digits :: [0..9],
                Num_in_base :: integer().
value(Ds, Base) -> 
    [D, T] = Ds,
    if 
        Ds =:= [] -> 0;
        D >= Base -> {error, invalid_digit};
        D <  0    -> {error, negative_digit};
        true      -> R = value(T, Base),
                     case R of
                        {error, _} -> R;
                        _ -> D + Base * R
                     end
    end. 
     

-spec digits(Number, Base) -> 
            Digits when
                Number :: integer(), 
                Base :: pos_integer(), 
                Digits :: [0..9].
digits(N, B) ->
    case N of
        0 -> [];
        _ -> [N rem B | digits(N div B, B)]
    end.

