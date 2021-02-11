-module(custom_set).

-export([add/2, 
		 contains/2, 
		 difference/2, 
		 disjoint/2, 
		 empty/1, 
		 equal/2, 
		 from_list/1, 
		 intersection/2, 
		 subset/2,
	 	 union/2
		]).

-spec add(any(), list()) -> list().
add(Elem, Set) -> 
	maps:put(Elem, true, Set).

-spec contains(any(), list()) -> boolean().
contains(Elem, Set) -> 
	maps:get(Elem, Set, false).

-spec difference(list(), list()) -> list().
difference(Set1, Set2) -> 
	maps:without(maps:keys(Set2), Set1).

-spec disjoint(list(), list()) -> boolean().
disjoint(Set1, Set2) -> 
	maps:size(intersection(Set1, Set2)) =:= 0.

-spec empty(list()) -> boolean.
empty(Set) -> 
	maps:size(Set) =:= 0.

-spec equal(list(), list()) -> boolean().
equal(Set1, Set2) -> 
	Set1 =:= Set2.

-spec from_list(list()) -> list().
from_list(List) -> 
	maps:from_list([{Elem, true} || Elem <- List]).

-spec intersection(list(), list()) -> list().
intersection(Set1, Set2) -> 
	from_list([E || E <- maps:keys(Set1), contains(E, Set2)]).
	% [Elem || Elem <- Set1, contains(Elem, Set2)].

-spec subset(list(), list()) -> boolean().
subset(Set1, Set2) -> 
	lists:all(fun(E) -> contains(E, Set2) end, maps:keys(Set1)).

-spec union(list(), list()) -> list().
union(Set1, Set2) -> 
	maps:merge(Set1, Set2).
