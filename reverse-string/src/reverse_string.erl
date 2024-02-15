-module(reverse_string).

-export([reverse/1]).

-spec reverse([char()]) -> [char()].
reverse(String) -> 
    reverse(String, []).

% Auxiliary

-spec reverse([char()], [char()]) -> list(char()).
reverse(String, Reversed) ->
    case String of
        [] -> Reversed;
        [H | T] -> reverse(T, [H | Reversed])   
    end.
