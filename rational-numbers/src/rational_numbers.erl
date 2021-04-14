-module(rational_numbers).

-export([absolute/1, add/2, divide/2, exp/2, mul/2, reduce/1, sub/2]).

-type rational() :: {integer(), integer()}.


-spec absolute(rational()) -> rational().
absolute(R) -> 
    {X, Y} = R,
    {abs(X), abs(Y)}.

-spec add(rational(), rational()) -> rational().
add(R1, R2) -> 
    {X1, Y1} = R1,
    {X2, Y2} = R2,
    reduce({X1 * Y2 + X2 * Y1, Y1 * Y2}).

-spec divide(rational(), rational()) -> rational().
divide(R1, R2) -> 
    {X1, Y1} = R1,
    {X2, Y2} = R2,
    reduce({X1 * Y2, X2 * Y1}).

-spec exp(rational(), integer()) -> rational().
exp(Base, Exponent) -> 
    {X, Y} = Base,
    reduce({pow(X, Exponent), pow(Y, Exponent)}).

-spec mul(rational(), rational()) -> rational().
mul(R1, R2) -> 
    {X1, Y1} = R1,
    {X2, Y2} = R2,
    reduce({X1 * X2, Y1 * Y2}).

-spec reduce(rational()) -> rational().
reduce(R) -> 
    {X, Y} = R,
    sign({X div gcd(X, Y), Y div gcd(X, Y)}).     

-spec sub(rational(), rational()) -> rational().
sub(R1, R2) -> 
    {X1, Y1} = R1,
    {X2, Y2} = R2,
    reduce({X1 * Y2 - X2 * Y1, Y1 * Y2}).


% Auxiliary

-spec sign(rational()) -> rational().
sign({X, Y}) ->
    case Y < 0 of
        true -> {-X, -Y};
        false -> {X, Y}
    end.  

-spec gcd(integer(), integer()) -> integer().
gcd(X, Y) -> 
    case Y =:= 0 of
        true -> abs(X);
        false -> gcd(Y, X rem Y)
    end. 

-spec pow(integer(), integer()) -> integer().
pow(B, E) ->
    case E =:= 0 of
        true -> 1;
        false -> B * pow(B, E - 1)
    end.
