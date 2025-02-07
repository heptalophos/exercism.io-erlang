-module(robot_simulator).
-behaviour(gen_statem).

% public API
-export([create/0, place/3, direction/1, position/1, left/1, right/1, advance/1]).

% methods for gen_fsm
-export([init/1, handle_event/3, handle_sync_event/4, terminate/3]).

% FSM - though there's only one state currently : ()
-export([idle/3, idle/2]).

% (L)eft, (R)ight, (A)dvance
-define(VALID_COMMANDS, "LRA").

-record(robot,
        {direction=undefined,
        position={undefined, undefined}
        }).

init(_Args) ->
  State = #robot{},
  {ok, idle, State}.

handle_event(_Event, StateName, StateData) ->
  {next_state, StateName, StateData}.
handle_sync_event(_Event, _From, StateName, StateData) ->
  {reply, ok, StateName, StateData}.
terminate(_Reason, _StateName, _StateData) ->
    ok.

% 'getters'
idle({get_direction}, _From, State) ->
  {reply, State#robot.direction, idle, State};
idle({get_position}, _From, State) ->
  {reply, State#robot.position, idle, State}.

% the set/action methods don't expect a reply
idle({set_position, Position}, State) ->
  {next_state, idle, State#robot{position=Position}};
idle({set_direction, Direction}, State) ->
  {next_state, idle, State#robot{direction=Direction}};
idle({turn, WhichWay}, State) ->
  NewDirection = change_direction(State#robot.direction, WhichWay),
  {next_state, idle, State#robot{direction=NewDirection}};
idle({advance}, State) ->
  NewPosition = move(State#robot.direction, State#robot.position),
  {next_state, idle, State#robot{position=NewPosition}}.

create() ->
  % we could use this to pass arguments to our init function
  Args = [], Options = [],
  {ok, Pid} = gen_statem:start_link(?MODULE, Args, Options),
  Pid.

place(Robot, Direction, Position) ->
  gen_statem:cast(Robot, {set_direction, Direction}),
  gen_statem:cast(Robot, {set_position, Position}).

direction(Robot) ->
  gen_statem:call(Robot, {get_direction}).

position(Robot) ->
  gen_statem:call(Robot, {get_position}).

left(Robot) ->
  gen_statem:cast(Robot, {turn, left}).

right(Robot) ->
  gen_statem:cast(Robot, {turn, right}).

advance(Robot) ->
  gen_statem:cast(Robot, {advance}).

change_direction(north, left)   -> west;
change_direction(north, right)  -> east;
change_direction(west, left)    -> south;
change_direction(west, right)   -> north;
change_direction(south, left)   -> east;
change_direction(south, right)  -> west;
change_direction(east, left)    -> north;
change_direction(east, right)   -> south.

move(north, {X, Y}) -> {X, Y+1};
move(west, {X, Y})  -> {X-1, Y};
move(south, {X, Y}) -> {X, Y-1};
move(east, {X, Y})  -> {X+1, Y}.