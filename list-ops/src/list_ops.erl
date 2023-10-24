-module(list_ops).
-compile({no_auto_import,[length/1]}).
-author("heptalophos").

-export([append/2, concat/1, filter/2, length/1, 
		 map/2, foldl/3, foldr/3, reverse/1]).

-type predicate() :: fun((any()) -> boolean()).
-type transform() :: fun((any()) -> any()).
-type injection() :: fun((any(), any()) -> any()).


-spec foldl (injection(), any(), list()) -> any().
foldl (Fn, Acc, List) ->
	case List of
		[] -> Acc;
		[H | Ts] -> foldl ( Fn, Fn(H, Acc), Ts )
	end.

-spec foldr (injection(), any(), list()) -> any().
foldr (Fn, Acc, List) -> 
	case List of
		[] -> Acc;
		[H | Ts] -> Fn ( H, foldr (Fn, Acc, Ts) )
	end.

% all other ops, are defined in terms of foldl or foldr, 
% using appropriate (mostly "append/2"-based) injections

-spec append (list(), list()) -> list().
append (Xs, Ys) -> foldr ( fun (X, Acc) -> [X | Acc] end, Ys, Xs ).

-spec concat (list()) -> list().
concat (List) -> foldl ( fun (Acc, Xs) -> append (Xs, Acc) end, [], List ).

-spec filter (predicate(), list()) -> list().
filter (Pred, List) ->
	foldl (	fun (L, Acc) -> 
				case Pred(L) of 
					true  -> append (Acc, [L]);
					false -> Acc
				end
		 	end, 
		 	[], List ). 

-spec length (list()) -> non_neg_integer().
length (List) -> foldl (fun (_, Acc) -> Acc + 1 end, 0, List).

-spec map (transform(), list()) -> list().
map (Transform, List) ->
	case List of
		[] -> [];
		_  -> foldl ( fun (L, Acc) -> append (Acc, [Transform(L)]) end, 
		  	         [], List )
	end.

-spec reverse (list()) -> list().
reverse (List) -> foldr (fun (L, Acc) -> append (Acc, [L]) end, [], List).
