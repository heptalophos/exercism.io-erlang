-module(palindrome_products).

-export([largest/2, smallest/2]).

-spec largest(integer(), integer()) -> 
	{integer(), [{integer(), integer()}]} | error.
largest(Min, Max) -> 
    case Min > Max of
        true -> error(invalid_range);
        _ -> PfPs = palindromic_factor_pairs(Min, Max, dn),
			 if
				PfPs =:= [] -> undefined;
				true -> MaxP = lists:max([(X * Y) || {X, Y} <- PfPs]),
						{MaxP, [{X, Y} || {X, Y} <- PfPs, (X * Y) =:= MaxP]}
		     end
	end.

-spec smallest(integer(), integer()) -> 
	{integer(), [{integer(), integer()}]} | error.
smallest(Min, Max) -> 
    case Min > Max of
        true -> error(invalid_range);
        _ -> PfPs = palindromic_factor_pairs(Min, Max, up),
			 if
				PfPs =:= [] -> undefined;
				true -> MinP = lists:min([(X * Y) || {X, Y} <- PfPs]),
						{MinP, [{X, Y} || {X, Y} <- PfPs, (X * Y) =:= MinP]}
		     end
    end.

% Auxiliary

-spec is_palindrome(integer()) -> boolean().
is_palindrome(Product) ->
    S = integer_to_list(Product),
	[F|_] = S,
	[L|_] = lists:reverse(S),
    case [F] =/= [L] of
    	true -> false;
        _ -> S == lists:reverse(S)
    end.

-spec palindromic_factor_pairs(integer(), integer(), up|dn) -> 
			[{integer(), integer()}] | {error, atom()}.
palindromic_factor_pairs(Min, Max, Dir) ->
	case {Dir, Max - Min > 9} of
		{up, true} -> 
			NMax = Min + (Min div 5),
			[{X, Y} || 	X <- lists:seq(Min, NMax), Y <- lists:seq(X, NMax), 
							 is_palindrome(X * Y)];
		{dn, true} -> 
			NMin = Max - (Max div 5),
			[{X, Y} || 	X <- lists:seq(NMin, Max), Y <- lists:seq(X, Max), 
							 is_palindrome(X * Y)];
		{_, false} -> 
			[{X, Y} || 	X <- lists:seq(Min, Max), Y <- lists:seq(X, Max), 
							 is_palindrome(X * Y)];
		{_, _} -> {error, invalid_range}
	end.
