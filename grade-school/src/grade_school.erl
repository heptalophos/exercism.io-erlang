-module(grade_school).

-author("heptalophos").

-export([add/3, get/2, get/1, new/0]).

-type grade() :: 1..8.
-type student() :: unicode:chardata().
-type school() :: [{grade(), student()}].

-spec new() -> school().
new() -> [].

-spec add(student(), grade(), school()) -> school().
add(Name, Grade, School) -> 
    Names = lists:sort([S || {_, S} <- School]),
    case lists:member(Name, Names) of 
        true -> School; 
        _ -> [{Grade, Name} | School]
    end.

-spec get(grade(), school()) -> [student()].
get(Grade, School) -> 
    [Student || {_, Student} <- lists:sort([{G, _S} 
             || {G, _S} <- School, G =:= Grade])].

-spec get(school()) -> [student()].
get(School) -> 
    lists:sort([Student || {_, Student} <- School]).
