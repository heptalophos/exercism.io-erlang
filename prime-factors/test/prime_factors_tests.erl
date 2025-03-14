%% Generated with 'testgen v0.2.0'
%% Revision 1 of the exercises generator was used
%% https://github.com/exercism/problem-specifications/raw/42dd0cea20498fd544b152c4e2c0a419bb7e266a/exercises/prime-factors/canonical-data.json
%% This file is automatically generated from the exercises canonical data.

-module(prime_factors_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_no_factors_test_'() ->
    {"no factors",
     ?_assertEqual(lists:sort([]),
		   lists:sort(prime_factors:factors(1)))}.

'2_prime_number_test_'() ->
    {"prime number",
     ?_assertEqual(lists:sort([2]),
		   lists:sort(prime_factors:factors(2)))}.

'3_square_of_a_prime_test_'() ->
    {"square of a prime",
     ?_assertEqual(lists:sort([3, 3]),
		   lists:sort(prime_factors:factors(9)))}.

'4_cube_of_a_prime_test_'() ->
    {"cube of a prime",
     ?_assertEqual(lists:sort([2, 2, 2]),
		   lists:sort(prime_factors:factors(8)))}.

'5_product_of_primes_and_non_primes_test_'() ->
    {"product of primes and non-primes",
     ?_assertEqual(lists:sort([2, 2, 3]),
		   lists:sort(prime_factors:factors(12)))}.

'6_product_of_primes_test_'() ->
    {"product of primes",
     ?_assertEqual(lists:sort([5, 17, 23, 461]),
		   lists:sort(prime_factors:factors(901255)))}.

'7_factors_include_a_large_prime_test_'() ->
    {"factors include a large prime",
     ?_assertEqual(lists:sort([11, 9539, 894119]),
		   lists:sort(prime_factors:factors(93819012551)))}.

% '8_factors_include_another_large_prime_test_'() ->
%     {"factors include a large prime",
%      ?_assertEqual(lists:sort([5, 2000000011]),
% 		   lists:sort(prime_factors:factors(10000000055)))}.
