-module(etl).
-author(heptalophos).

-export([transform/1]).

-type legacy() :: [{pos_integer(), [string()]}].
-type migrated() :: [{string(), pos_integer()}].

-spec transform(legacy()) -> migrated().
transform(Legacy) -> 
    Transformation =
        fun({Letter, Points}, Transformed) ->
            Reformatted = 
                lists:map(fun (L) -> 
                    {string:to_lower(L), Letter} 
                          end, 
                Points),
            lists:merge(Transformed, Reformatted)
        end,
    lists:foldl(Transformation, [], Legacy).