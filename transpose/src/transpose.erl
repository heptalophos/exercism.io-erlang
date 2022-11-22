-module(transpose).

-export([transpose/1]).

-spec transpose([string()]) -> [string()].
transpose(Lines) -> 
    case is_empty(Lines) of
        true -> 
            [];
        _    ->
            Hs = [H || [H|_] <- Lines],
            Ts = [T || [_|T] <- Lines],
            case not lists:all(fun is_empty/1, Ts) of
                true -> 
                    [Hs | transpose(pad(Ts))];
                _    -> 
                    [Hs] %% stop
            end
    end.

% Auxiliary

-spec is_empty(list()) -> boolean().
is_empty(Ls) -> 
    lists:all(fun(L) -> L =:= [] end, Ls).

-spec pad(list(string())) -> list(string()).
pad(Ls) -> 
    Reversed = lists:reverse(Ls),
    Empty    = lists:takewhile(fun is_empty/1, Reversed), 
    ToPad    = lists:dropwhile(fun is_empty/1, Reversed),
    Padded   = lists:map(fun(L) -> 
                            case is_empty(L) of 
                                true -> " "; 
                                _    -> L 
                            end
                         end, 
                         ToPad
                        ), 
    lists:reverse(Empty ++ Padded).
