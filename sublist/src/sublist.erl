-module(sublist).

-export([is_equal/2, is_sublist/2, is_superlist/2, is_unequal/2, relation/2]).


-spec is_equal(List1, List2) -> boolean() when
    List1 :: [T], List2 :: [T], T :: term().
is_equal(L1, L2) -> 
    case relation(L1, L2) of 
        equal -> true;
        _ -> false
    end.

-spec is_sublist(List1, List2) -> boolean() when
    List1 :: [T], List2 :: [T], T :: term().
is_sublist(L1, L2) -> 
    case (relation(L1, L2)) of
        equal -> true;
        sublist -> true;
        _ -> false 
    end.

-spec is_superlist(List1, List2) -> boolean() when
    List1 :: [T], List2 :: [T], T :: term().
is_superlist(L1, L2) ->     
    case (relation(L1, L2)) of
        equal -> true;
        superlist -> true;
        _ -> false 
    end.

-spec is_unequal(List1, List2) -> boolean() when
    List1 :: [T], List2 :: [T], T :: term().
is_unequal(L1, L2) ->
    case (relation(L1, L2)) of
        equal -> false;
        _ -> true
    end.

-spec relation(List1, List2) -> atom() when
    List1 :: [T], List2 :: [T], T :: term().
relation(L1, L2) -> 
    case { infix(L1, L2), infix(L2, L1) } of
        {true, true}   -> equal;
        {true, false}  -> sublist;
        {false, true}  -> superlist;
        {false, false} -> unequal
    end.

% Auxiliary

-spec infix(List1, List2) -> boolean() when
    List1 :: [T], List2 :: [T], T :: term().
% infix(L1, L2) ->
%     lists:all(fun(X) -> lists:member(X, L2) end, L1).
infix(L1, L2) -> 
    case {L1, L2} of
        {L1, []} -> L1 == [];
        {L1, L2} ->
            [_ | R] = L2, 
            case lists:prefix(L1, L2) of
                false  -> infix(L1, R);
                _      -> true
            end
    end.
