-module(nucleotide_count).

-export([count/2, nucleotide_counts/1]).

-spec valid([char()]) -> [char()] | {error, atom()}.
valid(N) when N =:= "A" orelse N =:= "C" orelse N =:= "G" orelse N =:= "T" -> N;
valid(_) -> erlang:error(invalid_nucleotide).

-spec count(string(), [char()]) -> non_neg_integer().
count(Strand, Nucleotide) -> 
    string:length(lists:filter(fun(X) -> valid([X]) =:= Nucleotide end, Strand)).

-spec nucleotide_counts(string()) -> {[char()], non_neg_integer()}.
nucleotide_counts(Strand) -> 
    lists:map(fun(X) -> {X, count(Strand, X)} end, ["A", "C", "G", "T"]).
