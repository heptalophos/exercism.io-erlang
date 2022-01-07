-module(beer_song).

-export([verse/1, sing/1, sing/2]).

-spec verse(non_neg_integer()) -> string().
verse(N) -> [premise(N), conclusion(N)].

-spec sing(non_neg_integer()) -> string().
sing(N) -> sing(N, 0).

-spec sing(non_neg_integer(), non_neg_integer()) -> string().
sing(From, To) -> lists:flatten(
                    [
                      [verse(N), io_lib:nl()] ||
                      N <- lists:reverse(
                              lists:seq(To, From)
                           )
                    ]).

% Auxiliary

-spec premise(non_neg_integer()) -> string().
premise(N) -> 
    case N of
      0 -> 
        "No more bottles of beer on the wall, no more bottles of beer.\n";
      1 ->
        "1 bottle of beer on the wall, 1 bottle of beer.\n";
      _ -> 
        io_lib:format(
          "~B bottles of beer on the wall,"
          " ~B bottles of beer.\n", 
          [N, N]
        )
    end.

-spec conclusion(non_neg_integer()) -> string().
conclusion(N) ->
    case N of
      0 -> 
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
      1 -> 
        "Take it down and pass it around, no more bottles of beer on the wall.\n";
      2 ->
        "Take one down and pass it around, 1 bottle of beer on the wall.\n";
      _ -> 
        io_lib:format(
          "Take one down and pass it around,"
          " ~B bottles of beer on the wall.\n", 
          [N-1]
        )
    end.