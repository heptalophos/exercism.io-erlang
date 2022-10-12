-module(transpose).

-export([transpose/1, is_empty/1, pad/1]).

-spec transpose([string()]) -> [string()].
transpose(Lines) -> 
    case is_empty(Lines) of
        true -> [];
        _    ->
            Heads = [H || [H|_] <- Lines],
            Tails = [T || [_|T] <- Lines],
            case not lists:all(fun is_empty/1, Tails) of
                true -> [Heads | transpose(pad(Tails))];
                _    -> [Heads]
            end
    end.

% Auxiliary

-spec is_empty(list()) -> boolean().
is_empty(Ls) -> lists:all(fun(L) -> L =:= [] end, Ls).

-spec pad(list()) -> list().
pad(Ls) -> 
    Reversed = lists:reverse(Ls),
    Empty    = lists:takewhile(fun is_empty/1, Reversed), 
    ToPad    = lists:dropwhile(fun is_empty/1, Reversed),
    Padded   = lists:map(fun(L) -> 
                            case is_empty(L) of 
                                true -> " "; 
                                _ -> L 
                            end
                         end, 
                         ToPad
                        ), 
    lists:reverse(Empty ++ Padded).
