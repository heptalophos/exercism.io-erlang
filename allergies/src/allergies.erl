-module(allergies).
-author(heptalophos).

-export([allergies/1, is_allergic_to/2]).

-type score() :: pos_integer().
-type allergen() :: atom().

-define (ALLERGIES, [eggs, peanuts, shellfish, 
                     strawberries, tomatoes, 
                     chocolate, pollen, cats]).


-spec allergies(score()) -> [allergen()].
allergies(Score) -> allergies(Score, ?ALLERGIES).

-spec is_allergic_to(allergen(), score()) -> boolean().
is_allergic_to(Substance, Score) -> 
    lists:member(Substance, allergies(Score)).


% Auxiliary

-spec allergies(score(), [allergen()]) -> [allergen()].
allergies(_, []) -> [];
allergies(S, [A | As]) -> 
    case S rem 2 of 
        0 -> 
            allergies(S div 2, As);
        _ -> 
            [A | allergies(S div 2, As)]
    end.