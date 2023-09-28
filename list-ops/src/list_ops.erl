-module(list_ops).
-compile({no_auto_import,[length/1]}).
-author("heptalophos").

-export([append/2, concat/1, filter/2, length/1, 
		 map/2, foldl/3, foldr/3, reverse/1]).

-type pred() :: fun((any()) -> boolean()).
-type transform() :: fun((any()) -> any()).
-type injection() :: fun((any(), any()) -> any()).

-spec append(list(), list()) -> list().
append(Xs, Ys) ->
	foldr(fun(X, Acc) -> [X | Acc] end, Ys, Xs).

-spec concat(list()) -> list().
concat(Ls) ->
	foldl(fun(Acc, Xs) -> append(Xs, Acc) end, [], Ls).

-spec filter(pred(), list()) -> list().
filter(Pred, Ls) ->
	foldl(	fun(L, Acc) -> 
				case Pred(L) of 
					true -> append(Acc, [L]);
					false -> Acc
				end
		 	end, 
		 	[], Ls	). 

-spec length(list()) -> non_neg_integer().
length(Ls) -> 
	foldl(fun(_, Acc) -> Acc + 1 end, 0, Ls).

-spec map(transform(), list()) -> list().
map(_, []) -> [];
map(Transform, Ls) ->
	foldl(	fun(L, Acc) -> 
				append(Acc, [Transform(L)]) 
		  	end, 
		  	[], Ls	).

-spec foldl(injection(), any(), list()) -> any().
foldl(Fn, Acc, Ls) ->
	case Ls of
		[] -> Acc;
		[H | Ts] -> foldl(Fn, Fn(H, Acc), Ts)
	end.

-spec foldr(injection(), any(), list()) -> any().
foldr(Fn, Acc, Ls) -> 
	case Ls of
		[] -> Acc;
		[H | Ts] -> Fn(H, foldr(Fn, Acc, Ts))
	end.

-spec reverse(list()) -> list().
reverse(Ls) -> 
	foldl(fun(L, Init) -> [L | Init] end, [], Ls).

%% Auxiliary
