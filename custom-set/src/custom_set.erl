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

-record(custom_set, {elements = [] :: [any()]}).

-type custom_set() :: #custom_set{}.

-export_type([custom_set/0]).


-spec contains(any(), custom_set()) -> boolean().
contains(_, Set) when Set#custom_set.elements == [] -> 
	false;
contains(Elem, Set) -> 
	#custom_set{elements = Elements} = Set,
	[H|T] = Elements,
	case H of
		Elem -> true;
		_ -> contains(Elem, #custom_set{elements = T})
	end.

-spec add(any(), custom_set()) -> custom_set().
add(Elem, Set) -> 
	#custom_set{elements = Elems} = Set,
	case contains(Elem, Set) of
		true -> 
			Elements = Elems;
		false -> 
			Elements = [Elem|Elems]
	end,
	#custom_set{elements = Elements}.

-spec difference(custom_set(), custom_set()) -> custom_set().
difference(Set1, Set2) -> 
	#custom_set{elements = Elements1} = Set1,
	#custom_set{elements = Elements2} = Set2,
	#custom_set{elements = Elements1 -- Elements2}.

-spec disjoint(custom_set(), custom_set()) -> boolean().
disjoint(Set1, Set2) -> 
	#custom_set{elements = Elements1} = Set1,
	difference(Set1, Set2) == #custom_set{elements = Elements1}.

-spec empty(custom_set()) -> boolean().
empty(Set) ->
	Set#custom_set.elements == [].

-spec equal(custom_set(), custom_set()) -> boolean().
equal(Set1, Set2) -> 
	difference(Set1, Set2) == #custom_set{elements = []} 
	andalso 
	difference(Set2, Set1) == #custom_set{elements = []}.

-spec from_list(list()) -> custom_set().
from_list(List) -> 
	#custom_set{elements = 
		lists:foldl(fun(Elem, Acc) -> 
					[Elem] ++ Acc 
				end, 
				[], 
				List)}.

-spec intersection(custom_set(), custom_set()) -> custom_set().
intersection(Set1, Set2) -> 
	#custom_set{elements = Elements1} = Set1,
	#custom_set{elements = Elements2} = Set2,
	#custom_set{elements = 
		lists:filter(fun(Elem) -> 
					 contains(Elem, 
					 		 #custom_set{elements = Elements2}) 
		             end, 
					 Elements1)}.

-spec subset(custom_set(), custom_set()) -> boolean().
subset(Set1, Set2) -> 
	#custom_set{elements = Elements1} = Set1,
	#custom_set{elements = Elements2} = Set2,
	lists:all(fun(Elem) -> 
				contains(Elem, 
						 #custom_set{elements = Elements2}) 
			  end, 
			  Elements1).

-spec union(custom_set(), custom_set()) -> custom_set().
union(Set1, Set2) -> 
	#custom_set{elements = Elements1} = Set1,
	#custom_set{elements = Elements2} = Set2,
	#custom_set{elements = 
		dedup(lists:foldl(fun(Elem, Acc) -> 
							[Elem] ++ Acc 
						  end, 
						  Elements1, 
						  Elements2))}.

%Auxiliary 

-spec dedup(list()) -> list().
dedup(List) -> 
	ordsets:from_list(ordsets:to_list(List)).