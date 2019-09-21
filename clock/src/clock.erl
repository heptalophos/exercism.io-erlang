-module(clock).

-author("heptalophos").

-export([create/2, 
         is_equal/2, 
         minutes_add/2, 
         to_string/1]).

-type hour() :: 0..23.
-type minute() :: 0..59.
-type time() :: 0..1339.

-record(clock, {time = 0 :: time()}).
-type clock() :: #clock{}.

-spec create(hour(), minute()) -> clock().
create(Hour, Minute) -> 
    Sum = minutes(Hour, Minute),
    H = Sum div 60,
    M = Sum rem 60,
    {H, M}.

-spec is_equal(clock(), clock()) -> boolean().
is_equal(Clock1, Clock2) -> 
    Clock1 == Clock2.

-spec minutes_add(clock(), integer()) -> clock().
minutes_add(Clock, Minutes) -> 
    {H, M} = Clock,
    create(H, M + Minutes).

-spec to_string(clock()) -> string(). 
to_string(Clock) -> 
    {H, M} = Clock,
    lists:flatten(io_lib:format("~2..0B:~2..0B", {H div 60, M rem 60})).


% Auxiliary


-spec minutes(hour(), minute()) -> minute().
minutes(Hour, Minute) -> 
    Sum = (Hour * 60 + Minute) rem 1440,
    if 
        Sum < 0 -> 1440 + Sum;
        true    -> Sum
    Sum.
