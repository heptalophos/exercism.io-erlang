-module(resistor_color).

-export([colors/0, color_code/1]).

-type resistor_color() :: black 
                        | brown 
                        | red 
                        | orange 
                        | yellow 
                        | green 
                        | blue 
                        | violet 
                        | grey 
                        | white.

-spec colors() -> list(resistor_color()).
colors() ->
    [black, brown, red, orange, yellow,
     green, blue, violet, grey, white].

-spec color_code(resistor_color()) -> 0..9 | {error, atom()}. 
color_code(Color) ->
    color_code(Color, colors(), 0).

% Auxiliary

-spec color_code(resistor_color(), list(resistor_color()), 
                 non_neg_integer()) -> 0..9 | {error, atom()}.
color_code(C, Cs, P) ->
    [_|T] = Cs,
    case {C, Cs, P} of
        {_, [], _} -> {error, color_not_found};
        {Color, [Color|_], N} -> N;
        {Color, [_|T], N} -> color_code(Color, T, N + 1)
    end.
