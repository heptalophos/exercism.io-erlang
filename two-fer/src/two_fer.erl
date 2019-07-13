-module(two_fer).

-export([two_fer/0, two_fer/1]).


-spec two_fer() -> nonempty_string().
two_fer() -> two_fer("you").

-spec two_fer(nonempty_string()) -> nonempty_string().
two_fer(Name) -> 
    lists:flatten(["One for ", Name, ", one for me."]).
