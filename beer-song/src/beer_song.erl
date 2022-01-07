-module(beer_song).

-export([verse/1, sing/1, sing/2]).

-spec verse(non_neg_integer()) -> string().
verse(_N) ->
  undefined.

-spec sing(non_neg_integer()) -> string().
sing(_N) ->
  undefined.

-spec sing(non_neg_integer(), non_neg_integer()) -> string().
sing(_From, _To) ->
  undefined.

% Auxiliary


