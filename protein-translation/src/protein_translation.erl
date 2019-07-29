-module(protein_translation).
-export([proteins/1, proteins/2]).


-type aminoacid() :: methionine |
                     phenylalanine |
                     leucine |
                     serine |
                     tyrosine |
                     cysteine |
                     tryptophan. 
-type control_seq() :: stop.
-type polypeptide() :: [aminoacid()].


-spec proteins(string()) -> polypeptide().
proteins(Strand) -> lists:reverse(proteins(Strand, [])).


% auxiliary

-spec proteins([char()], [char()]) -> polypeptide().
proteins([], Polypeptide) -> Polypeptide;
proteins([X, Y, Z | Rest], Polypeptide) -> 
    case codon2amino([X, Y, Z]) of
        stop -> proteins([], Polypeptide);
        AA   -> proteins(Rest, [AA | Polypeptide])
    end.

-spec codon2amino(string()) -> aminoacid() | control_seq().
codon2amino("AUG") -> methionine;
codon2amino("UUU") -> phenylalanine;
codon2amino("UUC") -> phenylalanine;
codon2amino("UUA") -> leucine;
codon2amino("UUG") -> leucine;
codon2amino("UCU") -> serine;
codon2amino("UCC") -> serine;
codon2amino("UCA") -> serine;
codon2amino("UCG") -> serine;
codon2amino("UAU") -> tyrosine;
codon2amino("UAC") -> tyrosine;
codon2amino("UGU") -> cysteine;
codon2amino("UGC") -> cysteine;
codon2amino("UGG") -> tryptophan;
codon2amino("UAA") -> stop;
codon2amino("UAG") -> stop;
codon2amino("UGA") -> stop.