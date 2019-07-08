-module(scrabble_score).
-author("heptalophos").

-export([score/1]).


-spec score(string()) -> non_neg_integer().
score(Word) -> 
    lists:foldl(fun(X, Sum) -> 
                    X + Sum end, 
                    0,
                    lists:map(fun letter_score/1, string:to_upper(Word))).

% auxiliary

-spec letter_score(char) -> non_neg_integer().
letter_score(L) ->
    [{_, Score}] = maps:to_list(maps:filter(fun (Sc, _) -> 
            lists:member(L, Sc) end, scores())),
    Score.

-spec scores() -> {[char()], non_neg_integer()}.
scores() ->
    #{ [$A, $E, $I, $O, $U, $L, $N, $R, $S, $T] => 1,
       [$D, $G] => 2,
       [$B, $C, $M, $P] => 3,
       [$F, $H, $V, $W, $Y] => 4,
       [$K] => 5,
       [$J, $X] => 8,
       [$Q, $Z] => 10 }.