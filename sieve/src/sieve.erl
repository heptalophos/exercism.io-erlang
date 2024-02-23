-module(sieve).

-export([primes/1]).


-spec primes(Limit) -> [Prime] 
        when Limit :: pos_integer(), 
             Prime :: pos_integer().
primes(Limit) -> 
    Nums = lists:seq(2, Limit),
    sieve(Nums, [], Limit).

% Auxiliary

-spec sieve([Number], [Prime], Limit) -> [Prime] 
      when Number :: pos_integer(), 
           Prime  :: pos_integer(), 
           Limit  :: pos_integer(). 
sieve(Numbers, Primes, _Limit) -> 
    case Numbers of 
        [] -> lists:reverse(Primes);
        [Num|Nums] -> Comps = lists:seq(2 * Num, _Limit, Num),
                      sieve(Nums -- Comps, [Num|Primes], _Limit)
    end.
