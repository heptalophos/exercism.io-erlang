-module(saddle_points).

-export([saddle_points/1]).

-spec saddle_points([[integer()]]) -> [{integer(), integer()}].
saddle_points(Matrix) ->
	Saddle_point = 
		fun (R, C) ->
			Row = lists:nth(R, Matrix),
			Col = [lists:nth(C, Nth) || Nth <- Matrix],
			Val = lists:nth(C, lists:nth(R, Matrix)),
			Val =:= lists:max(Row) andalso 
			Val =:= lists:min(Col)			  
		end,
	[{R - 1, C - 1} || R <- lists:seq(1, length(Matrix)), 
					   C <- lists:seq(1, length(hd(Matrix))), 
					   Saddle_point(R, C)].
