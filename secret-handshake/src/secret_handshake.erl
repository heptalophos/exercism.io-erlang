-module(secret_handshake).

-export([commands/1]).

-spec commands(pos_integer()) -> [string()].
commands(Number) -> 
    Commands = lists:filter(
        fun(X) -> X =/= nil end,
        [ case Number band 16#01 =/= 0 of 
                true -> "wink";
                _    ->  nil 
          end,
          case Number band 16#02 =/= 0 of 
                true -> "double blink";    
                _    ->  nil 
          end,
          case Number band 16#04 =/= 0 of 
                true -> "close your eyes"; 
                _    ->  nil 
          end,
          case Number band 16#08 =/= 0 of 
                true -> "jump";
                _    ->  nil 
          end ]
    ),
    case Number band 16#10 =/= 0 of 
        true -> lists:reverse(Commands);
        _    -> Commands
    end.
