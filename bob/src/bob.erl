-module(bob).

-export([response/1]).


-spec response(string()) -> string().
response(String) ->
    case ({question(String), yell(String), silence(String)}) of
        {true, true,    _}  -> "Calm down, I know what I'm doing!";
        {true,    _,    _}  -> "Sure.";
        {   _, true,    _}  -> "Whoa, chill out!";
        {   _,    _, true}  -> "Fine. Be that way!";
        {   _,    _,    _}  -> "Whatever."
    end.

%% auxiliary fcns
-spec question(string()) -> boolean().
question(S) -> 
    string:find(string:trim(S, trailing), "?") == "?".

-spec silence(string()) -> boolean().
silence(S) -> 
    string:is_empty(string:trim(S)).

-spec yell(string()) -> boolean().
yell(S) -> 
    string:to_upper(S) =:= S andalso S =/= string:casefold(S).