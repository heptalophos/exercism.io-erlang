-module(rna_transcription).

-export([to_rna/1]).

-type dna() :: [$A|$T|$C|$G].
-type rna() :: [$A|$C|$G|$U].

-spec to_rna(dna()) -> rna().
to_rna(Strand) -> 
    lists:map(fun(S) -> 
        maps:get(S, #{ $G => $C, $C => $G, $T => $A, $A => $U }) end, 
    Strand).