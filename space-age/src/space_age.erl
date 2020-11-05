-module(space_age).

-export([age/2]).

-define(EARTH_YEAR, 31557600).

-type planet() :: mercury | 
                  venus | 
                  earth | 
                  mars | 
                  jupiter | 
                  saturn | 
                  uranus | 
                  neptune.

-spec age(planet(), integer()) -> float().
age(Planet, Seconds) ->
    %% Orbital Period (in Earth Years) 
    OrbitalPeriod = 
        case Planet of
            mercury -> 0.24084670;
            venus   -> 0.61519726;
            earth   -> 1.00000000;
            mars    -> 1.88081580;
            jupiter -> 11.8626150;
            saturn  -> 29.4474980;
            uranus  -> 84.0168460;
            neptune -> 164.791320
        end,
    Seconds / ?EARTH_YEAR / OrbitalPeriod.
