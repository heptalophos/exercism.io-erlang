-module(sieve).

-export([primes/1]).


-spec primes(Limit) -> [Prime] 
      when 
      Limit :: pos_integer(), 
      Prime :: pos_integer().
primes(Limit) -> 
    Nums = lists:seq(2, Limit),
    sieve(Nums, [], Limit).


% Auxiliary

-spec sieve([Number], [Prime], Limit) -> [Prime] 
      when Number :: pos_integer(),
           Prime  :: pos_integer(),
           Limit :: pos_integer(). 
sieve([], Primes, _) ->
    lists:reverse(Primes);
sieve([Num|Nums], Primes, Limit) ->
    Comp = lists:seq(2 * Num, Limit, Num),
    sieve(Nums -- Comp, [Num|Primes], Limit).