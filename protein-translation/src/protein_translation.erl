-module(protein_translation).
-export([proteins/1]).

-type aminoacid() :: methionine |
                     phenylalanine |
                     leucine |
                     serine |
                     tyrosine |
                     cysteine |
                     tryptophan. 
-type control_seq() :: stop.
-type polypeptide() :: [aminoacid()].

-spec proteins(string()) -> {ok, polypeptide()} | {error, atom()}.
proteins(Strand) ->
    Proteins = proteins(Strand, []),
    Valid_Strand = lists:all(fun (X) -> lists:member(X, "ACGU") end, Strand),
    Valid_Polypeptide = lists:all(fun (X) -> X =/= unknown end, Proteins),
    case Valid_Strand andalso Valid_Polypeptide of 
        true -> {ok, lists:reverse(Proteins)};
        _    -> {error, badarg}
    end.

% Auxiliary

-spec proteins([char()] | [atom()], polypeptide()) -> [aminoacid() | atom()].
%%% Quick update of previous version to comply with new tests...
proteins([unknown], Polypeptide) -> [unknown | Polypeptide];
proteins([], Polypeptide) -> Polypeptide;
proteins([X, Y, Z | Rest], Polypeptide) ->
    case codon2amino([X, Y, Z]) of
        stop    -> proteins([], Polypeptide);
        unknown -> proteins([unknown], Polypeptide);
        Amino   -> proteins(Rest, [Amino | Polypeptide])       
    end;
proteins([_ | _], Polypeptide) -> proteins([unknown], Polypeptide).
%%%  Ugly, ugly, ugly 😀... 

-spec codon2amino(string()) -> aminoacid() | control_seq() | atom().
codon2amino(Codon) ->
    case Codon of
        [$A, $U, $G] -> methionine;
        [$U, $U, $U] -> phenylalanine;
        [$U, $U, $C] -> phenylalanine;
        [$U, $U, $A] -> leucine;
        [$U, $U, $G] -> leucine;
        [$U, $C, $U] -> serine;
        [$U, $C, $C] -> serine;
        [$U, $C, $A] -> serine;
        [$U, $C, $G] -> serine;
        [$U, $A, $U] -> tyrosine;
        [$U, $A, $C] -> tyrosine;
        [$U, $G, $U] -> cysteine;
        [$U, $G, $C] -> cysteine;
        [$U, $G, $G] -> tryptophan;
        [$U, $A, $A] -> stop;
        [$U, $A, $G] -> stop;
        [$U, $G, $A] -> stop;
        _ -> unknown
    end.
