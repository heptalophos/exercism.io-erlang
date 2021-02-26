-module(nth_prime).

-export([prime/1]).

-spec prime(pos_integer()) -> pos_integer()|{error, string()}.
prime(N) -> case N of
                0 -> error("badarg 0");
                1 -> 2;
                _ -> prime(N, 1)
            end.


% Auxiliary Functions

-spec prime(pos_integer(), pos_integer()) -> pos_integer().
prime(N, C) -> 
    Truth = fun (X) -> 
                case X of 
                    true  -> 1; 
                    false -> 0
                end 
            end,
    case N of 
        1 -> C;
        _ -> prime(N - Truth(is_prime(C + 2)), C + 2)
    end.
    
-spec is_prime(pos_integer()) -> boolean().
is_prime(N) -> 
    case N of 
        1 -> false;
        2 -> true;
        _ -> lists:all(fun(X) -> N rem X =/= 0 end, 
                       lists:seq(2, ceil(math:sqrt(N))))
    end.