-module(triangle).

-export([kind/3]).

-type triangle_form() :: equilateral | isosceles | scalene.

-spec triangle_inequality([integer()]) -> atom().
triangle_inequality([A, B, C]) when (C < (A + B)) -> valid_triangle;
triangle_inequality([_, _, _]) -> violated_triangle_inequality.

-spec is_valid(number(), number(), number()) -> atom().
is_valid(A, B, C) when ((A =< 0) or (B =< 0) or (C =< 0)) -> not_all_sides_positive;
is_valid(A, B, C) -> triangle_inequality(lists:sort([A, B, C])).

-spec triangle(integer()) -> triangle_form().
triangle(1) -> equilateral;
triangle(2) -> isosceles;
triangle(3) -> scalene.

-spec kind(number(), number(), number()) -> triangle_form() | {error, string()}.
kind(A, B, C) -> 
    case is_valid(A, B, C) of
        not_all_sides_positive       -> {error, "all side lengths must be positive"};
        violated_triangle_inequality -> {error, "side lengths violate triangle inequality"};
        valid_triangle               -> triangle(sets:size(sets:from_list([A, B, C])))
    end.
