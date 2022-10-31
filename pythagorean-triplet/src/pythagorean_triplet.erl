-module(pythagorean_triplet).
-export([triplets_with_sum/1]).
-type triplet() :: {pos_integer(), pos_integer(), pos_integer()}.

-spec triplets_with_sum(pos_integer()) -> list(triplet()).
triplets_with_sum(Limit) -> triplets_with_sum(Limit, 1).

% Auxiliary

-spec triplets_with_sum(pos_integer(), pos_integer()) -> list(triplet()).
triplets_with_sum(Sum, Start) -> 
    case Sum div 3 >= Start of
        true -> 
            A = Start,
	        B = (square(Sum) - 2 * Sum * A) div (2 * Sum - 2 * A),
            R = (square(Sum) - 2 * Sum * A) rem (2 * Sum - 2 * A),
	        C = Sum - A - B,
            Not_Pythagorean = R =/= 0 orelse A - B >= 0,
            if Not_Pythagorean -> 
                    triplets_with_sum(Sum, A + 1); % continue
               true -> 
                    [{A, B, C} | triplets_with_sum(Sum, A + 2)]
            end;
        false -> []
	end.

-spec square(pos_integer()) -> pos_integer().
square(N) -> N * N.

% -spec is_pythagorean(triplet()) -> boolean().
% is_pythagorean(Triple) ->
%     {A, B, C} = lists:sort(fun (X, Y) -> Y >= X end, Triple),
%     2 * square(C) =:= square(A) + square(B) + square(C).
