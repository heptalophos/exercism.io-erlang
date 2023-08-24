-module(word_count).
-export([count_words/1]).

-spec count_words(string()) -> #{string() => pos_integer()}.
count_words(Sentence) -> 
    lists:foldl(fun (Word, Count) -> 
                    maps:update_with(Word, fun(X) -> X + 1 end, 1, Count) 
                end,
                maps:new(), 
                words(Sentence)).

% Auxiliary
-spec words(string()) -> [string()].
words(Sentence) -> 
    Sanitized = 
        string:to_lower(re:replace(Sentence, "[!&@$%&:.^]+", "",
                                   [global, {return, list}])),
    Words = 
        string:lexemes(Sanitized, [$\n, $\s, $\,]), [string:trim(W, both, "'") 
                                                     || W <- Words].
