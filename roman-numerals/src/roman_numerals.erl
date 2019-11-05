-module(roman_numerals).

-export([roman/1]).

-spec roman(non_neg_integer()) -> string().
roman(Number) -> roman(Number, "").


% Auxiliary

-spec roman(non_neg_integer(), string()) -> string().
roman(Number, Acc) when Number >= 1000 -> 
    roman(Number - 1000, Acc ++ "M");
roman(Number, Acc) when Number >= 900 -> 
    roman(Number - 900, Acc ++ "CM");
roman(Number, Acc) when Number >= 500 -> 
    roman(Number - 500, Acc ++ "D");
roman(Number, Acc) when Number >= 400 -> 
    roman(Number - 400, Acc ++ "CD");
roman(Number, Acc) when Number >= 100 -> 
    roman(Number - 100, Acc ++ "C");
roman(Number, Acc) when Number >= 90 -> 
    roman(Number - 90, Acc ++ "XC");
roman(Number, Acc) when Number >= 50 -> 
    roman(Number - 50, Acc ++ "L");
roman(Number, Acc) when Number >= 40 -> 
    roman(Number - 40, Acc ++ "XL");
roman(Number, Acc) when Number >= 10 -> 
    roman(Number - 10, Acc ++ "X");
roman(Number, Acc) when Number >= 9 -> 
    roman(Number - 9, Acc ++ "IX");
roman(Number, Acc) when Number >= 5 -> 
    roman(Number - 5, Acc ++ "V");
roman(Number, Acc) when Number >= 4 -> 
    roman(Number - 4, Acc ++ "IV");
roman(Number, Acc) when Number >= 1 -> 
    roman(Number - 1, Acc ++ "I");
roman(0, Acc) -> Acc.