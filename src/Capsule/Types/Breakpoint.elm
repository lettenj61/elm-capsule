module Capsule.Types.Breakpoint exposing
    ( Breakpoint
    , desktop
    , fullHd
    , tablet
    , touch
    , widescreen
    , toString
    )

-- BREAKPOINTS


type Breakpoint
    = Breakpoint String


touch : Breakpoint
touch =
    Breakpoint "touch"


tablet : Breakpoint
tablet =
    Breakpoint "tablet"


desktop : Breakpoint
desktop =
    Breakpoint "desktop"


widescreen : Breakpoint
widescreen =
    Breakpoint "widescreen"


fullHd : Breakpoint
fullHd =
    Breakpoint "fullhd"


toString : Breakpoint -> String
toString (Breakpoint breakpoint) =
    breakpoint
