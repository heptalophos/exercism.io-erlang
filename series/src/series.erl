-module(series).

-export([slices/2]).

-spec slices(pos_integer(), [any()]) -> 
                            [any()] | error.
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
slices(SLength, Series, SubSeries) ->
    case length(Series) < SLength of
        true -> lists:reverse(SubSeries);
        _ -> [_|Rest] = Series,
             slices(SLength, Rest, 
                    [lists:sublist(Series, SLength) | SubSeries])
    end.
