-module(simple_linked_list).

-export([cons/2, 
         count/1, 
         empty/0,
         head/1, 
         tail/1,
         reverse/1, 
         from_native_list/1, 
         to_native_list/1]).

-record(node, {payload = none :: undefined | any(), 
               next = none :: undefined | sl_list()}).

-type sl_list() :: #node{}.

-spec empty() -> sl_list().
empty() -> 
    #node{payload = none, next = none}.

-spec cons(any(), sl_list()) -> sl_list().
cons(Elt, List) -> 
    #node{payload = Elt, next = List}.

-spec head(sl_list()) -> any() | error.
head(List) -> 
    case List =/= empty() of
        true -> List#node.payload;
        false -> error(badarg)
    end.

-spec tail(sl_list()) -> sl_list().
tail(List) -> 
    case List =/= empty() of
        true -> List#node.next;
        false -> empty()
    end.

-spec reverse(sl_list()) -> sl_list().
reverse(List) -> 
    case List =:= empty() of
        true -> empty();
        false -> 
            fold(fun(X, Acc) -> 
                    cons(X, Acc) 
                 end,
                 empty(),
                 List)
    end.

-spec count(sl_list()) -> 
        fun((sl_list(), pos_integer()) -> pos_integer()).
count(List) -> count(List, 0).

-spec to_native_list(sl_list()) -> list().
to_native_list(List) -> 
    #node{payload = H, next = T} = List,
    case List  =:= empty() of 
        true -> [];
        false -> [H | to_native_list(T)]
    end.

-spec from_native_list(list()) -> sl_list().
from_native_list(NativeList) ->
    case NativeList of 
        [] -> empty();
        [H | T] -> 
            #node{payload = H, 
                  next = from_native_list(T)}
    end.

% Auxiliary

-spec count(sl_list(), pos_integer()) -> pos_integer().
count(List, Length) ->
    case List  =/= empty() of
        true -> count(List#node.next, Length + 1);
        _ -> Length  
    end.

-spec fold((fun()), any(), sl_list()) -> any().
fold(Function, Start, List) -> 
    #node{payload = H, next = T} = List,
    case List =:= empty() of
        true -> Start;
        _ -> fold(Function, Function(H, Start), T)
    end.