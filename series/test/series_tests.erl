-module(series_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").


'1_slices_of_one_from_one_test_'() ->
    {"slices of one from one",
     ?_assertEqual(["1"], series:slices(1, "1"))}.

'2_slices_of_one_from_two_test_'() ->
    {"slices of one from two",
     ?_assertEqual(["1", "2"], series:slices(1, "12"))}.

'3_slices_of_two_test_'() ->
    {"slices of two",
     ?_assertEqual(["35"], series:slices(2, "35"))}.

'4_slices_of_two_overlap_test_'() ->
    {"slices of two overlap",
     ?_assertEqual(["91", "14", "42"],
		   series:slices(2, "9142"))}.

'5_slices_can_include_duplicates_test_'() ->
    {"slices can include duplicates",
     ?_assertEqual(["777", "777", "777", "777"],
		   series:slices(3, "777777"))}.

'6_slices_of_a_long_series_test_'() ->
    {"slices of a long series",
     ?_assertEqual(["91849", "18493", "84939", "49390",
		    "93904", "39042", "90424", "04243"],
		   series:slices(5, "918493904243"))}.

'7_slice_length_is_too_large_test_'() ->
    {"slice length is too large",
     ?_assertError(_, series:slices(6, "12345"))}.

'8_slice_length_cannot_be_zero_test_'() ->
    {"slice length cannot be zero",
     ?_assertError(_, series:slices(0, "12345"))}.

'9_slice_length_cannot_be_negative_test_'() ->
    {"slice length cannot be negative",
     ?_assertError(_, series:slices(-1, "123"))}.

'10_empty_series_is_invalid_test_'() ->
    {"empty series is invalid",
     ?_assertError(_, series:slices(1, []))}.


%% Generated with 'testgen v0.2.0'
%% Revision 1 of the exercises generator was used
%% https://github.com/exercism/problem-specifications/raw/42dd0cea20498fd544b152c4e2c0a419bb7e266a/exercises/series/canonical-data.json