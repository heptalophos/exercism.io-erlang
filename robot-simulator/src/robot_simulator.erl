-module(robot_simulator).

-behaviour(gen_server).

-export([advance/1, create/0, 
         direction/1, left/1, 
         place/3, position/1, 
         right/1]).

-export([init/1, handle_call/3, handle_cast/2]).

-type direction() :: north | east | south | west.
-type position() :: { X :: integer(), 
                      Y :: integer() }.

-record(robot, { pid = undefined :: pid() | undefined }).

-record(state, {position = {undefined, undefined} :: position(), 
                direction = undefined :: direction()}).

-type(robot() :: #robot{}).

-spec advance(robot()) -> none().
advance(Robot) -> 
   #robot{pid = Pid} = Robot,
   gen_server:cast(Pid, advance).

-spec create() -> robot(). 
create() -> 
   % {ok, Pid} = start_link(#robot{}),
   {ok, PID} = gen_server:start_link(?MODULE, [], []),
   #robot{pid = PID}.

-spec direction(robot()) -> none().
direction(Robot) -> 
   #robot{pid = Pid} = Robot,
   gen_server:call(Pid, direction).

-spec left(robot()) -> none().
left(Robot) -> 
   #robot{pid = Pid} = Robot,
   gen_server:cast(Pid, {clockwise}).

-spec place(robot(), direction(), position()) -> none().
place(Robot, Direction, Position) -> 
   #robot{pid = Pid} = Robot,
   gen_server:cast(Pid, {position, Position}),
   gen_server:cast(Pid, {direction, Direction}).

-spec position(robot()) -> position().
position(Robot) -> 
   #robot{pid = Pid} = Robot,
   gen_server:call(Pid, position).

-spec right(robot()) -> none().
right(Robot) -> 
   #robot{pid = Pid} = Robot,
   gen_server:cast(Pid, {counter_clockwise}).

% Auxiliary

-spec(advance(position(), direction()) -> position()).
advance(P, D)  ->
   {X, Y} = P,
   case D of 
      east  -> {X + 1, Y};
      west  -> {X - 1, Y};
      north -> {X, Y + 1}; 
      south -> {X, Y - 1}
   end.

turn_left(D) ->
   case D of
      north -> west;
      west  -> south;
      south -> east;
      east  -> north 
   end.

turn_right(D) ->
   case D of
      north -> east;
      west  -> north;
      south -> west;
      east  -> south 
   end.

%% gen_server callbacks

% start_link(Name) ->
%    gen_server:start_link({local, Name}, ?MODULE, [], []).

init(_) ->
   {ok, #state{}}.

handle_call(Request, _, _) ->
   case Request of 
      position -> 
         {reply, Request, #state{position = Request}};
      direction -> 
         {reply, Request, #state{direction = Request}}
      end.

handle_cast(Msg, State) ->
   case Msg of
      {direction, Direction} ->
         {noreply, #state{direction = Direction}};
      {position, Position} ->
         {noreply, #state{position = Position}};
      {counter_clockwise} ->
         D = turn_left(State#state.direction),
         handle_cast({direction, D}, State);
      {clockwise} ->
         D = turn_right(State#state.direction),
         handle_cast({direction, D}, State);
      {advance} ->
         D = advance(State#state.position, State#state.direction),
         handle_cast({position, D}, State)
      end.
%% clockwise_plus, clockwise_minus