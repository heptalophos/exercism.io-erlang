-module(protein_translation).
-export([proteins/1, proteins/2]).


-type protein() :: methionine |
                   phenylalanine |
                   leucine |
                   serine |
                   tyrosine |
                   cysteine |
                   tryptophan. 
-type control_seq() :: stop.
-type polypeptide() :: [protein()].


-spec proteins(string()) -> polypeptide().
proteins(Strand) -> lists:reverse(proteins(Strand, [])).


% auxiliary

-spec proteins([char()], [char()]) -> polypeptide().
proteins([], Polypeptide) -> Polypeptide;
proteins([X, Y, Z | Rest], Polypeptide) -> 
    case codon([X, Y, Z]) of
        stop -> proteins([], Polypeptide);
        AA   -> proteins(Rest, [AA | Polypeptide])
    end.

-spec codon(string()) -> protein() | control_seq().
codon("AUG") -> methionine;
codon("UUU") -> phenylalanine;
codon("UUC") -> phenylalanine;
codon("UUA") -> leucine;
codon("UUG") -> leucine;
codon("UCU") -> serine;
codon("UCC") -> serine;
codon("UCA") -> serine;
codon("UCG") -> serine;
codon("UAU") -> tyrosine;
codon("UAC") -> tyrosine;
codon("UGU") -> cysteine;
codon("UGC") -> cysteine;
codon("UGG") -> tryptophan;
codon("UAA") -> stop;
codon("UAG") -> stop;
codon("UGA") -> stop.