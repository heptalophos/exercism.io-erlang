-module(roman_numerals).

-export([roman/1]).

-spec roman(Number) -> Roman_Numeral when
            Number :: non_neg_integer(),
            Roman_Numeral :: string().
roman(Number) -> roman(Number, []).

% Auxiliary

-spec roman(Arabic, Latin_Acc) -> Roman_Numeral when
            Arabic :: non_neg_integer(), 
            Latin_Acc :: string(),
            Roman_Numeral :: string().
roman(Num, Acc) ->
    if
        Num >= 1000 -> 
            roman(Num - 1000, Acc ++ "M");
        Num >= 900 -> 
            roman(Num - 900, Acc ++ "CM");
        Num >= 500 -> 
            roman(Num - 500, Acc ++ "D");
        Num >= 400 -> 
            roman(Num - 400, Acc ++ "CD");
        Num >= 100 -> 
            roman(Num - 100, Acc ++ "C");
        Num >= 90 -> 
            roman(Num - 90, Acc ++ "XC");
        Num >= 50 -> 
            roman(Num - 50, Acc ++ "L");
        Num >= 40 -> 
            roman(Num - 40, Acc ++ "XL");
        Num >= 10 -> 
            roman(Num - 10, Acc ++ "X");
        Num >= 9 -> 
            roman(Num - 9, Acc ++ "IX");
        Num >= 5 -> 
            roman(Num - 5, Acc ++ "V");
        Num >= 4 -> 
            roman(Num - 4, Acc ++ "IV");
        Num >= 1 -> 
            roman(Num - 1, Acc ++ "I");
        true -> Acc
    end.