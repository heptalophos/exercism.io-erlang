-module(clock).

-author("heptalophos").

-export([create/2, 
         is_equal/2, 
         minutes_add/2, 
         to_string/1]).

-type hour() :: 0..23.
-type minute() :: 0..59.
-type clock() :: {hour(), minute()}.

-spec create(integer(), integer()) -> clock().
create(Hours, Minutes) -> 
    Hour = 
        minutes(Hours, Minutes) div 60,
    Minute = 
        minutes(Hours, Minutes) rem 60,
    {Hour, Minute}.

-spec is_equal(clock(), clock()) -> boolean().
is_equal(Clock1, Clock2) -> 
    Clock1 =:= Clock2.

-spec minutes_add(clock(), integer()) -> clock().
minutes_add(Clock, Minutes) -> 
    {Hour, Minute} = Clock,
    create(Hour, Minute + Minutes).

-spec to_string(clock()) -> string(). 
to_string(Clock) -> 
    {Hour, Minute} = Clock,
    io_lib:format("~2..0B:~2..0B", [Hour, Minute]).

% Auxiliary 

-spec minutes(integer(), integer()) -> integer().
minutes(Hours, Minutes) -> 
    ((Hours * 60 + Minutes) rem 1440 + 1440) rem 1440.