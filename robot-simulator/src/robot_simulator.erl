-module(robot_simulator).

-export([advance/1, create/0, direction/1, left/1, place/3, position/1, right/1]).


-record(state, {server, position = {undefined, undefined}, direction=undefined}).


advance(_Robot) -> undefined.

create() -> undefined.

direction(_Robot) -> undefined.

left(_Robot) -> undefined.

place(_Robot, _Direction, _Position) -> undefined.

position(_Robot) -> undefined.

right(_Robot) -> undefined.
