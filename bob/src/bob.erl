-module(bob).
-author(heptalophos).

-export([response/1]).


-spec response(string()) -> string().
response(String) ->

    Yell     = quasibool(yell(String)), 
    Silence  = quasibool(silence(String)),
    Question = quasibool(question(String)),
    Calm = "Calm down, I know what I'm doing!",
    Sure = "Sure.",
    Whoa = "Whoa, chill out!",
    Fine = "Fine. Be that way!",
    Whatever = "Whatever.",

    case ({Question, Yell, Silence}) of
        {1, 1, 0} -> Calm;
        {1, 0, 0} -> Sure;
        {0, 1, 0} -> Whoa;
        {0, 0, 1} -> Fine;
        {_, _, _} -> Whatever
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
    string:to_upper(S) =:= S andalso 
    S =/= string:casefold(S).

-spec quasibool(boolean()) -> 1 | 0.
quasibool(Premise) -> 
    case Premise of
        true  -> 1;
        false -> 0
    end.