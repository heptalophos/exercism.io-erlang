-module(list_ops).
-compile({no_auto_import,[length/1]}).

-author("heptalophos").

-export([append/2, concat/1, 
		 filter/2, length/1, 
		 map/2, foldl/3, 
		 foldr/3, reverse/1]).

-type pred() :: fun((any()) -> boolean()).
-type transform() :: fun((any()) -> any()).
-type injection() :: fun((any(), any()) -> any()).

-spec append(list(), list()) -> list().
append([], List2) -> List2;
append([Element | List1], List2) -> [Element | append(List1, List2)].

-spec concat(list()) -> list().
concat([]) -> [];
concat([Element | List]) -> append(Element, concat(List)).

-spec filter(pred(), list()) -> list().
filter(_, []) -> [];
filter(Function, [Element | List]) -> 
	case Function(Element) of 
		true -> [Element | filter(Function, List)]; 
		false -> filter(Function, List) 
	end.

-spec length(list()) -> non_neg_integer().
length([]) -> 0;
length([_ | List]) -> 1 + length(List).

-spec map(transform(), list()) -> list().
map(_, []) -> [];
map(Function, [Element | List]) -> 
	[Function(Element) | map(Function, List)].

-spec foldl(injection(), any(), list()) -> any().
foldl(_, Start, []) -> Start;
foldl(Function, Start, [Element | List]) -> 
	foldl(Function, Function(Element, Start), List).

-spec foldr(injection(), any(), list()) -> any().
foldr(Function, Start, List) -> 
	foldl(Function, Start, reverse(List)).

-spec reverse(list()) -> list().
reverse(List) -> reverse(List, []).

%% auxiliary

-spec reverse(list(), list()) -> list().
reverse([], Acc) -> Acc;
reverse([X | List], Acc) -> reverse(List, [X | Acc]).
