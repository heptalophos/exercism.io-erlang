-module(word_count).
-export([count_words/1]).

% API
-spec count_words(string()) -> 
            #{string() => pos_integer()}.
count_words(Sentence) -> 
    lists:foldl(fun (Word, Count) -> 
                    maps:update_with(Word, 
                                     fun(X) -> 
                                         X + 1 end,
                                     1, 
                                     Count) 
                end,
                maps:new(),
                words(Sentence)).

% Auxiliary
-spec words(string()) -> [string()].
words(Sentence) ->
    [string:to_lower(Word) || 
     Word <- re:split(Sentence, 
                      "\\W'|'\\W|[^\\w']+", 
                      [{return, list}]), 
     Word =/= []].