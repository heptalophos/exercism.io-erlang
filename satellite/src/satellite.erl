-module(satellite).

-export([tree_from_traversals/2]).

-spec tree_from_traversals([any()], [any()]) -> #{v => any(),
                                                  l => {any()}, 
                                                  r => {any()}}.
tree_from_traversals(PreOrder, InOrder) -> 
    true = valid(PreOrder, InOrder),
    build_tree(PreOrder, InOrder).

% Auxiliary

-spec valid(list(), list()) -> boolean().
valid(P, I) ->
    lists:sort(P)  =:= lists:usort(P) andalso 
    lists:sort(I)  =:= lists:usort(I) andalso
    lists:usort(P) =:= lists:usort(I).

-spec build_tree([any()], [any()]) -> #{v => any(),l => {any()},r => {any()}}. 
build_tree(P, I) ->
    case {P, I} of
        {[],     []} -> #{};
        {[V|Ps], Is} -> 
            {LeftIs, [_|RightIs]} = 
                lists:split(string:str(Is, [V]) - 1, Is),
            LeftPs = lists:sublist(Ps, length(LeftIs)),
            RightPs = lists:nthtail(length(LeftPs), Ps),
            #{ 
             v => V, 
             l => build_tree(LeftPs, LeftIs), 
             r => build_tree(RightPs, RightIs) 
             }
    end.