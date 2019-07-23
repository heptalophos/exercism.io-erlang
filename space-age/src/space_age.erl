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
            mercury -> 0.2408467;
            venus   -> 0.61519726;
            earth   -> 1;
            mars    -> 1.8808158;
            jupiter -> 11.862615;
            saturn  -> 29.447498;
            uranus  -> 84.016846;
            neptune -> 164.79132
        end,
    Seconds / ?EARTH_YEAR / OrbitalPeriod.
