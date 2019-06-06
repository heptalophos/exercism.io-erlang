-module(bob).

-export([response/1]).


-spec response(string()) -> string().
response(String) -> 
    case ({question(String), yell(String), silence(String)}) of
        {1, 1, 0} -> "Calm down, I know what I'm doing!";
        {1, 0, 0} -> "Sure.";
        {0, 1, 0} -> "Whoa, chill out!";
        {0, 0, 1} -> "Fine. Be that way!";
        {_, _, _} -> "Whatever."
    end.

%% auxiliary fcns
-spec question(string()) -> 1 | 0.
question(S) ->
    case (string:find(string:trim(S, trailing), "?") == "?") of
        true  -> 1;
        false -> 0
    end.

-spec silence(string()) -> 1 | 0.
silence(S) ->
    case (string:is_empty(string:trim(S))) of
        true  -> 1;
        false -> 0
    end.

-spec yell(string()) -> 1 | 0.
yell(S) ->
    case (string:to_upper(S) =:= S andalso 
          S =/= string:casefold(S))
    of
        true  -> 1;
        false -> 0
    end.
