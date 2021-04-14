-module(series).

-export([slices/2]).

-spec slices(pos_integer(), [any()]) -> 
                            [any()] | {error, string()}.
slices(SliceLength, Series) ->
    if 
        SliceLength =< 0 ->
            error("vanishing or illegal slices");
        SliceLength > length(Series) ->
            error("slice can't be longer than series");
        true ->
            slices(SliceLength, Series, [])
    end.   


% Auxiliary

-spec slices(pos_integer(), [any()], [any()]) -> [any()].
slices(SLength, Series, SubSeries) 
    when length(Series) < SLength ->
                lists:reverse(SubSeries);
slices(SLength, Series = [_|Rest], SubSeries) -> 
    slices(SLength, 
           Rest, 
           [lists:sublist(Series, SLength) | SubSeries]).
