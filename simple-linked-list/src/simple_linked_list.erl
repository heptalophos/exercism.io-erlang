-module(simple_linked_list).

-export([cons/2, 
         count/1, 
         empty/0,
         head/1, 
         tail/1,
         reverse/1, 
         from_native_list/1, 
         to_native_list/1]).

-record(node, {payload :: any(), 
               next    :: node()}).

-record(sllist, {head  :: node(), 
                 tail  :: [node()], 
                 count :: pos_integer()}).

-record(sllist, {payload = none :: any(), next = [] :: [any()]}).

-type node() :: #node{}.

-type sl_list() :: #sllist{}.

-spec empty() -> sl_list().
empty() -> 
    #sllist{payload = none, next = []}.

-spec cons(any(), sl_list()) -> sl_list().
cons(Elt, List) -> 
    Count = 1 + #sllist.count,
    Next = List#node.next,
    #sllist{payload = Elt, next = List}.

head(List) -> 
    #sllist{payload = Head, next = _} = List,
    Head.

tail(List) -> 
    #sllist{payload = _, next = Tail} = List,
    Tail.

reverse(_List) -> undefined.

count(_List) -> undefined.

to_native_list(_List) -> undefined.

from_native_list(_NativeList) -> undefined.
