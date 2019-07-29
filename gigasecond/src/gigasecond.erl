-module(gigasecond).

-export([from/1]).

-define(GIGASEC, 1000000000).

-spec from(calendar:date() | calendar:datetime()) -> 
    calendar:datetime().

from(Date = { _Y, _M, _D }) -> 
    from({ Date, { 0, 0, 0 }});

from({ Date = { _Y, _M, _D }, Time = { _H, _Mi, _S }}) -> 
    Seconds = calendar:datetime_to_gregorian_seconds({ Date, Time }),
    calendar:gregorian_seconds_to_datetime(Seconds + ?GIGASEC).