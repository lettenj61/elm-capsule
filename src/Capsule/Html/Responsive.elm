module Capsule.Html.Responsive exposing
    ( backgroundColor
    , breakpoint
    , color
    , textColor
    )

import Capsule.Breakpoint exposing (Breakpoint(..))
import Capsule.Color exposing (Color(..))
import Capsule.Html.Internal as Modifier exposing (Modifier)



-- BREAKPOINT


breakpoint : Breakpoint -> Modifier -> Modifier
breakpoint (Breakpoint bp) =
    Modifier.addSuffix ("-" ++ bp)



-- COLORS


{-|

    whiteBox : Html msg
    whiteBox =
        div
            [ backgroundColor black ]
            [ span [] [ text "This is thick" ] ]

-}
backgroundColor : Color -> Modifier
backgroundColor (Color name) =
    Modifier.fromString ("has-background-" ++ name)


color : Color -> Modifier
color (Color name) =
    Modifier.fromString ("is-" ++ name)


textColor : Color -> Modifier
textColor (Color name) =
    Modifier.fromString ("has-text-" ++ name)
