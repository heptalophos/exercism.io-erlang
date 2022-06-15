-module(largest_series_product).

-export([largest_product/2]).

-spec largest_product(string(), integer()) -> integer() | erlang:error(atom()).
largest_product(Digits, Span) -> 
    case Span of 
        0 -> 1;
        N when N < 0 -> erlang:error(negative_span);
        N when N > length(Digits) -> erlang:error(span_larger_than_series);
        _ -> case digits_to_ints(Digits, []) of
                {ok, IntDigs} -> 
                    Products = [lists:foldl(fun erlang:'*'/2, 1, S) || 
                                S <- slices(IntDigs, Span, [])],
                    lists:max(Products);
                {error, _} -> 
                    erlang:error(invalid_digits)
             end
    end.   

% Auxiliary

-spec digits_to_ints(string(), list(integer())) -> {ok, list(integer())} | {error, atom()}.
digits_to_ints(Digits, Acc) -> 
    case Digits of 
        [] ->   
                {ok, Acc};
        [H | T] when H >= $0 andalso H =< $9 -> 
                digits_to_ints(T, [erlang:list_to_integer([H], 10) | Acc]);
        _  ->   
                {error, not_a_digit}
    end.

-spec slices(list(), integer(), list()) -> list().
slices([_H | T] = List, SliceLen, Acc) -> 
    case SliceLen > length(List) of
        true  -> Acc;
        false -> slices(T, SliceLen, [lists:sublist(List, SliceLen) | Acc])
    end.