-module(robot_simulator).
-behavior(gen_statem).

-export([callback_mode/0, init/1, handle_event/4]).
-export([advance/1, create/0, direction/1, left/1, place/3, position/1, right/1]).

-record(state, {xcoord, ycoord}).

-spec create() -> pid().
create() -> {ok, Pid} = start_link(), Pid.

-spec place(pid(), atom(), atom()) -> pid().
place(Pid, Direction, Position) ->
	gen_statem:cast(Pid, {place, Direction, Position}).

-spec left(pid()) -> gen_statem:event_handler_result().
left(Pid) -> turn(Pid, left).

-spec right(pid()) -> gen_statem:event_handler_result().
right(Pid) -> turn(Pid, right).

-spec advance(pid()) -> gen_statem:event_handler_result().
advance(Pid) -> gen_statem:cast(Pid, advance).

-spec direction(pid()) -> gen_statem:event_handler_result().
direction(Pid) -> direction(Pid, 5000).

-spec position(pid()) -> gen_statem:event_handler_result().
position(Pid) -> position(Pid, 5000).

-spec callback_mode() -> gen_statem:callback_mode_result().
callback_mode() -> handle_event_function.

-spec init([]) -> gen_statem:init_result([]).
init([]) -> {ok, not_placed, #state{}}.

-spec handle_event(gen_statem:event_type(), atom(), atom(), #state{}) -> 
                                gen_statem:event_handler_result([]).
handle_event(cast, {place, Direction, {X, Y}}, not_placed, State) when 	(
										Direction =:= north orelse	
                                        Direction =:= east orelse
                                        Direction =:= south orelse	
                                        Direction =:= west
									    ) andalso	is_integer(X) 
                                          andalso is_integer(Y) ->
            {next_state, Direction, State#state{xcoord = X, ycoord = Y}};
handle_event(cast, {turn, left}, north, State) -> {next_state, west, State};
handle_event(cast, {turn, left}, east, State) -> {next_state, north, State};
handle_event(cast, {turn, left}, south, State) -> {next_state, east, State};
handle_event(cast, {turn, left}, west, State) -> {next_state, south, State};
handle_event(cast, {turn, right}, north, State) -> {next_state, east, State};
handle_event(cast, {turn, right}, east, State) -> {next_state, south, State};
handle_event(cast, {turn, right}, south, State) -> {next_state, west, State};
handle_event(cast, {turn, right}, west, State) -> {next_state, north, State};
handle_event(cast, advance, north, State = #state{ ycoord = Y }) ->
	{next_state, north, State#state{ycoord = Y + 1}};
handle_event(cast, advance, east, State=#state{ xcoord = X}) ->
	{next_state, east, State#state{xcoord = X + 1}};
handle_event(cast, advance, south, State=#state{ ycoord = Y}) ->
	{next_state, south, State#state{ycoord = Y - 1}};
handle_event(cast, advance, west, State=#state{ xcoord = X}) ->
	{next_state, west, State#state{xcoord = X - 1}};
handle_event({call, From}, position, Direction, 
             State=#state{xcoord = X, ycoord = Y}) ->
	{next_state, Direction, State, [{reply, From, {X, Y}}]};
handle_event({call, From}, direction, not_placed, State) ->
	{next_state, not_placed, State, [{reply, From, undefined}]};
handle_event({call, From}, direction, Direction, State) ->
	{next_state, Direction, State, [{reply, From, Direction}]};
handle_event(_, _, StateName, State) -> { next_state, StateName, State }.

% Auxiliary

start_link() -> gen_statem:start_link(?MODULE, [], []).

position(Pid, Timeout) -> gen_statem:call(Pid, position, Timeout).

direction(Pid, Timeout) -> gen_statem:call(Pid, direction, Timeout).

turn(Pid, Direction) -> gen_statem:cast(Pid, {turn, Direction}).