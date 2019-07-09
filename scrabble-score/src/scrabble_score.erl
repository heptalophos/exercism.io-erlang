-module(scrabble_score).
-author("heptalophos").

-export([score/1]).

-spec score(string()) -> non_neg_integer().
score(Word) ->
    lists:foldl(fun(Score, Total) -> Total + Score end, 
                0,
                lists:map(fun(L) -> 
                                case lists:keyfind(L, 1, scores()) 
                                of
                                    {L, S} -> S;
                                    false -> 0
                                end
                          end, 
                          string:to_upper(Word))).


% auxiliary

-spec scores() -> [{char(), non_neg_integer()}].
scores() ->
    Scores = #{"AEIOULNRST" => 1,
               "DG" => 2,
               "BCMP" => 3,
               "FHVWY" => 4,
               [$K] => 5,
               "JX" => 8,
               "QZ" => 10 },
    lists:flatten([
                    [{X, Score} || X <- Letter] ||
                     {Letter, Score} <- maps:to_list(Scores)
                  ]).
