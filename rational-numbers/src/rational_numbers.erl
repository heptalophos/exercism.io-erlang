-module(rational_numbers).

-export([absolute/1, add/2, divide/2, 
         exp/2, mul/2, reduce/1, sub/2]).

-type rational() :: {Numerator :: integer(), Denominator :: integer()}.

-spec absolute(rational()) -> rational().
absolute(Rational) -> 
    {Num, Den} = Rational, 
    reduce({abs(Num), abs(Den)}).

-spec add(rational(), rational()) -> rational().
add(Rational1, Rational2) -> 
    {Num1, Den1} = Rational1,
    {Num2, Den2} = Rational2,
    reduce({Num1 * Den2 + Num2 * Den1, Den1 * Den2}).

-spec divide(rational(), rational()) -> rational().
divide(Rational1, Rational2) -> 
    {Num1, Den1} = Rational1,
    {Num2, Den2} = Rational2,
    reduce({Num1 * Den2, Num2 * Den1}).

-spec exp(rational(), integer()) -> rational();
         (number(), rational()) -> float();
         (rational(), float()) -> float().
exp(Base, Exponent) when Exponent < 0 ->
    {Num, Den} = Base,
    reduce({trunc(math:pow(Den, abs(Exponent))), 
            trunc(math:pow(Num, abs(Exponent)))});
exp(Base, Exponent) when is_integer(Exponent) -> 
    {Num, Den} = Base,
    reduce({ipow(Num, Exponent), ipow(Den, Exponent)});
exp(Base, Exponent) when is_number(Base) -> 
    {Num, Den} = Exponent,
    math:pow(Base, Num / Den);
exp(Base, Exponent) when is_float(Exponent) -> 
    {Num, Den} = Base,
    math:pow(Num, Exponent) / math:pow(Den, Exponent).

-spec mul(rational(), rational()) -> rational().
mul(Rational1, Rational2) -> 
    {Num1, Den1} = Rational1,
    {Num2, Den2} = Rational2,
    reduce({Num1 * Num2, Den1 * Den2}).

-spec reduce(rational()) -> rational().
reduce(Rational) -> 
    {Num, Den} = Rational,
    sign({Num div gcd(Num, Den), Den div gcd(Num, Den)}).     

-spec sub(rational(), rational()) -> rational().
sub(Rational1, Rational2) -> 
    {Num1, Den1} = Rational1,
    {Num2, Den2} = Rational2,
    reduce({Num1 * Den2 - Num2 * Den1, Den1 * Den2}).

% Auxiliary

-spec sign(rational()) -> rational().
sign(Rational) ->
    {X, Y} = Rational,
    case Y < 0 of
        true  -> {-X, -Y};
        false -> { X,  Y}
    end.  

-spec gcd(integer(), integer()) -> integer().
gcd(X, Y) -> 
    case Y =:= 0 of
        true  -> abs(X);
        false -> gcd(Y, X rem Y)
    end. 

-spec ipow(integer(), integer()) -> integer().
ipow(B, E) ->
    case E =:= 0 of
        true  -> 1;
        false -> B * ipow(B, E - 1)
    end.
