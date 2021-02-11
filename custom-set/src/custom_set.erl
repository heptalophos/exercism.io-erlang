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

-spec add(any(), set()) -> set().
add(_Elem, _Set) -> undefined.

-spec contains(any(), set()) -> boolean().
contains(_Elem, _Set) -> undefined.

-spec difference(set(), set()) -> set().
difference(_Set1, _Set2) -> undefined.

-spec disjoint(set(), set()) -> boolean().
disjoint(_Set1, _Set2) -> undefined.

-spec empty(set()) -> boolean.
empty(_Set) -> undefined.

-spec equal(set(), set()) -> boolean().
equal(_Set1, _Set2) -> undefined.

-spec from_list(list()) -> set().
from_list(_List) -> undefined.

-spec intersection(set(), set()) -> set().
intersection(_Set1, _Set2) -> undefined.

-spec subset(set(), set()) -> boolean().
subset(_Set1, _Set2) -> undefined.

-spec (union(set(), set()) -> set().)
union(_Set1, _Set2) -> undefined.
