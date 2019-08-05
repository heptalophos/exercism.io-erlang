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
    #clock{ time = normalize(minutes(Hour) + Minute)}.

-spec is_equal(clock(), clock()) -> boolean().
is_equal(Clock1, Clock2) -> 
    Clock1 == Clock2.

-spec minutes_add(clock(), integer()) -> clock().
minutes_add(Clock, Minutes) -> 
    #clock{ time = Original } = Clock,
    #clock{ time = normalize(Original + Minutes)}.

-spec to_string(clock()) -> string(). 
to_string(Clock) -> 
    #clock{ time = Minutes } = Clock,
    io_lib:format("~2..0B:~2..0B", split(Minutes)).


% Auxiliary

-spec minutes(hour()) -> minute().
minutes(Hour) -> Hour * 60.

% -spec split(integer()) -> [hour(), minute()].
split(Minutes) -> 
    [Minutes div 60, Minutes rem 60].

-spec normalize(integer()) -> minute().
normalize(Minutes) when Minutes < 0 ->
    Minutes rem 1440 + 1440;
normalize(Minutes) -> 
    Minutes rem 1440.