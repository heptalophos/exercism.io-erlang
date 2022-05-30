-module(largest_series_product).

-export([largest_product/2]).

-spec largest_product(string(), integer()) -> integer() | erlang_error:error(atom()).
largest_product(Digits, Span) -> 
    case Span of 
        0 -> 1;
        N when N < 0 -> erlang:error(negative_span);
        N when N > length(Digits) -> erlang:error(span_larger_than_series);
        _ -> case digits_to_ints(Digits, []) of
                {ok, IntList} -> Products = [lists:foldl(
                                            fun erlang:'*'/2, 
                                            1, 
                                            S) 
                                        || S <- series(IntList, Span, [])],
                            lists:max(Products);
                {error, _} -> erlang:error(invalid_digits)
             end
    end.    

% Auxiliary

-spec digits_to_ints(string(), list(integer())) -> list(integer()).
digits_to_ints(Digits, Acc) -> 
    case Digits of 
        [] -> {ok, Acc};
        [H | T] when H >= $0 andalso H =< $9 ->
            digits_to_ints(T, [list_to_integer([H]) | Acc]);
        _ -> {error, invalid_digit}
    end.

-spec series(list(integer()), integer(), list(integer())) -> list(integer()).
series([_ | T] = IntList, SpanLen, Acc) -> 
    case SpanLen > length(IntList) of
        true -> Acc;
        false -> series(T, SpanLen, [lists:sublist(IntList, SpanLen) | Acc])
    end.
