-module(palindrome_products).

-export([largest/2, smallest/2, palindromes/2, palindromes/3]).


largest(Min, Max) -> 
    case Min > Max of
        true -> {error, invalid_range};
        _ -> 
            Factors = lists:seq(Min, Max),
            palindromes(Factors, Factors, fun erlang:'>'/2)
    end.

smallest(Min, Max) -> 
    case Min > Max of
        true -> {error, invalid_range};
        _ -> 
            Factors = lists:seq(Min, Max),
            palindromes(Factors, Factors, fun erlang:'<'/2)
    end.

% Auxiliary

palindromes(Start, End) ->
	case Start =:= End of
		true -> [];
		_ -> 
			lists:flatten( palindromes( Start, Start, End ), 
						   palindromes( Start + 1, End ) )
	end.

palindromes(F, S, End) -> 
	if 
		S =:= End ->
			Product = F * End,
			Palindrome = is_palindrome(Product),
			case Palindrome of
				true -> 
					[ {{F, End}, Product} ];
				_ -> 
					[]
			end;
		true ->
			Product = F * S,
			Palindrome = is_palindrome(Product), 
			case Palindrome of
				true -> 
					% [ { { F, S }, Product } | palindromes( F, S + 1, End ) ];
					[ { {F, S}, Product } | palindromes( F, S + 1, End ) ];
				_ -> 
					palindromes(F, S + 1, End)
			end
	end.

is_palindrome(P) -> 
	S = integer_to_list(P), 
	R = lists:reverse(S), 
	if 
		S == R -> true; 
		true -> false 
	end.

% is_palindrome(A, B) ->
% 	is_palindrome(A * B).




