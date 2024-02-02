-module(rail_fence_cipher).

-export([decode/2, encode/2]).


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

-spec transpose(Text::string(), 
				StepToNextRail :: -1|+1,
				TextIndex :: pos_integer(), 
				CurrentZigOrZag :: [{pos_integer(), char()}], 
				Accumulator :: [{pos_integer(), char()}]) -> string().
transpose([], +1, _, Zig, Acc) ->
	lists:reverse(lists:flatten(lists:reverse(Zig) ++ Acc));
transpose([], -1, _, Zag, Acc) ->
	lists:flatten([lists:reverse(L) || L <- lists:reverse(Zag) ++ Acc]);
transpose(Text, +1, TxtIdx, [], Acc) ->
	[H | Tail] = Acc, transpose(Text, -1, TxtIdx, Tail, [H]);
transpose(Text, -1, TxtIdx, [], Acc) ->
	[H | Tail] = Acc, transpose(Text, +1, TxtIdx, Tail, [H]);
transpose(Text, DirNextRail, TxtIdx, ZigOrZag, Acc) ->
	[F | Rest] = Text, [H | Tail] = ZigOrZag,
	transpose(Rest, DirNextRail, TxtIdx + 1, Tail, [[{TxtIdx, F} | H] | Acc]).
