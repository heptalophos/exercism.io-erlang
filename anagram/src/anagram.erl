-module(anagram).

-export([find_anagrams/2]).

-spec find_anagrams(S::string(), Cs::[string()]) -> [string()].
find_anagrams(Subject, Candidates) -> 
    [Candidate || Candidate <- Candidates, 
                  is_anagram(Subject, Candidate) andalso
                  not duplicate(Subject, Candidate)].

% Auxiliary

-spec normal_form(S::string()) -> [char()].
normal_form(S) -> 
    lists:sort(string:casefold(S)).

-spec duplicate(S::string(), C::string()) -> boolean().
duplicate(S, C) -> 
    string:casefold(C) =:= string:casefold(S).

-spec is_anagram(S::string(), C::string()) -> boolean().
is_anagram(S, C) -> 
    normal_form(S) =:= normal_form(C).
