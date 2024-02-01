-module(rail_fence_cipher).

-export([decode/2, encode/2, transpose/2]).


-spec decode(string(), pos_integer()) -> string().
decode(Message, Rails) -> 
	[Char || {_, Char} <- lists:sort(
							lists:zipwith(
								fun(C, {I, _}) -> {I, C} end,
								Message, transpose(Message, Rails)
							)
						  )
	].

-spec encode(string(), pos_integer()) -> string().
encode(Message, Rails) -> 
    [Char || {_, Char} <- transpose(Message, Rails)].

% Auxiliary

-spec transpose(string(), pos_integer()) -> string().
transpose(Text, Rails) ->
	transpose(Text, +1, 0, [[] || _ <- lists:seq(1, Rails)], []).

-spec transpose(string(), -1|+1, pos_integer(), list(), list()) -> string().
transpose([], +1, _, Zig, Acc) ->
	lists:reverse(lists:flatten(lists:reverse(Zig) ++ Acc));
transpose([], -1, _, Zig, Acc) ->
	lists:flatten([lists:reverse(L) || L <- lists:reverse(Zig) ++ Acc]);
transpose(Text, +1, TIdx, [], Acc) ->
	[H | Tail] = Acc, transpose(Text, -1, TIdx, Tail, [H]);
transpose(Text, -1, TIdx, [], Acc) ->
	[H | Tail] = Acc, transpose(Text, +1, TIdx, Tail, [H]);
transpose(Text, DirNextRail, TIdx, Zig, Acc) ->
	[F | Rest] = Text, [H | Tail] = Zig,
	transpose(Rest, DirNextRail, TIdx + 1, Tail, [[{TIdx, F} | H] | Acc]).
