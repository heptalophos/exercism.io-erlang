-module(nucleotide_count).

-export([count/2, nucleotide_counts/1]).

-type nucleotide() :: $A | $C | $G | $T.
-type strand() :: [nucleotide()].
-type nuc_count() :: {nucleotide(), non_neg_integer()}.

-spec valid(nucleotide()) -> nucleotide() | {error, atom()}.
valid(N) when N =:= "A" orelse N =:= "C" orelse N =:= "G" orelse N =:= "T" -> N;
valid(_) -> erlang:error(invalid_nucleotide).

-spec count(strand(), nucleotide()) -> non_neg_integer().
count(Strand, Nucleotide) -> 
    string:length(lists:filter(fun(X) -> valid([X]) =:= Nucleotide end, Strand)).

-spec nucleotide_counts(strand()) -> [nuc_count()].
nucleotide_counts(Strand) -> 
    lists:map(fun(X) -> {X, count(Strand, X)} end, ["A", "C", "G", "T"]).
