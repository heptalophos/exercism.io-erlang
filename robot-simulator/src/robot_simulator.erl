-module(robot_simulator).

-export([advance/1, create/0, direction/1, left/1, place/3, position/1, right/1]).

-record(state, {server, position = {undefined, undefined}, direction=undefined}).


advance(Robot) -> undefined.

create() -> undefined.

direction(Robot) -> undefined.

left(Robot) -> undefined.

place(Robot, _Direction, _Position) -> undefined.

position(_Robot) -> undefined.

right(_Robot) -> undefined.

% Auxiliary
