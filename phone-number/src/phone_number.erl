-module(phone_number).

-export([number/1, areacode/1, pretty_print/1]).


-spec number(string()) -> [$0..$9].
number(String) ->
  case [C || C <- String, is_digit(C)] of
    [$1 | Ds] when length(Ds) == 10 -> 
      Ds;
    Ds when length(Ds) == 10 -> 
      Ds;
    _ -> lists:duplicate(10, $0)
  end.

-spec areacode(string()) -> [$0..$9].
areacode(String) ->
  [A1, A2, A3, X1, X2, X3, N1, N2, N3, N4] = number(String),
  {Area, _, _} = {[A1, A2, A3], [X1, X2, X3], [N1, N2, N3, N4]},
  Area.

-spec pretty_print(string()) -> string().
pretty_print(String) ->
  [A1, A2, A3, X1, X2, X3, N1, N2, N3, N4] = number(String),
  {Area, XChange, Number} = {[A1, A2, A3], [X1, X2, X3], [N1, N2, N3, N4]},
  lists:flatten(io_lib:format("(~s) ~s-~s", [Area, XChange, Number])).

% Auxiliary

-spec is_digit(char()) -> boolean().
is_digit(C) -> 
  if
    C >= $0 andalso $9 >= C -> true;
    true -> false
  end.