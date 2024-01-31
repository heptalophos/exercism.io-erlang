-module(rail_fence_cipher).

-export([decode/2, encode/2]).

-spec decode(string(), pos_integer()) -> string().
decode(Message, Rails) -> 
	[X || {_, X} <- lists:sort(
						lists:zipwith(
							fun(C, {I, _}) -> {I, C} end,
							Message,
							transpose(Message, Rails)
						)
					)
	].

-spec encode(string(), pos_integer()) -> string().
encode(Message, Rails) -> 
    [X || {_, X} <- transpose(Message, Rails)].

% Auxiliary

-spec transpose(string(), pos_integer()) -> string().
transpose(Text, Rails) ->
	transpose(Text, dn, 0, [[] || _ <- lists:seq(1, Rails)], []).

-spec transpose( string(), atom(), pos_integer(),list(), list()) -> string().
transpose([], dn, _, Original, Transposed) ->
	lists:reverse(lists:flatten(lists:reverse(Original) ++ Transposed));
transpose([], up, _, Original, Transposed) ->
	lists:flatten(
		[lists:reverse(List) || List <- lists:reverse(Original) ++ Transposed]
	);
transpose(Text, dn, Index, [], Transposed) ->
	[Hd | Tail] = Transposed, transpose(Text, up, Index, Tail, [Hd]);
transpose(Text, up, Index, [], Transposed) ->
	[Hd | Tail] = Transposed, transpose(Text, dn, Index, Tail, [Hd]);
transpose(Text, Dir, Index, Original, Transposed) ->
	[Fst | Rest] = Text, [Hd | Tail] = Original,
	transpose(Rest, Dir, Index + 1, Tail, [[{Index, Fst} | Hd] | Transposed]).