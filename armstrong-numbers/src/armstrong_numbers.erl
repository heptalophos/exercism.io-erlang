-module(armstrong_numbers).
-author(heptalophos).

-export([is_armstrong_number/1]).

-spec is_armstrong_number(non_neg_integer()) -> boolean().
is_armstrong_number(Number) when Number >= 0 -> 
    Digits = [list_to_integer([Digit]) 
              || Digit <- integer_to_list(Number)],
    Len = length(Digits),
    Number =:= lists:foldl(fun(D, Acc) -> 
                Acc + round(math:pow(D, Len)) end, 
                0, 
                Digits).
