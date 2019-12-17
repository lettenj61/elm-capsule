module Capsule.Modifier exposing
    ( backgroundColor, color, danger, dark, light, link
    , primary, secondary, size, success, textColor, warning
    )

import Html exposing (Attribute)
import Html.Attributes exposing (class)


type Color
    = Color String


type Breakpoint
    = Touch
    | Tablet
    | Desktop
    | Widescreen
    | FullHD



-- COLORS


primary : Color
primary =
    Color "primary"


secondary : Color
secondary =
    Color "secondary"


success : Color
success =
    Color "success"


danger : Color
danger =
    Color "danger"


warning : Color
warning =
    Color "warning"


link : Color
link =
    Color "link"


dark : Color
dark =
    Color "dark"


light : Color
light =
    Color "light"



-- MODIFIERS

{-|

    whiteBox : Html msg
    whiteBox =
      div
        [ backgroundColor black ]
        [ span [] [ text "This is thick" ] ]
-}
backgroundColor : Color -> Attribute msg
backgroundColor (Color name) =
    class <| "has-background-" ++ name


color : Color -> Attribute msg
color (Color name) =
    class <| "is-" ++ name


textColor : Color -> Attribute msg
textColor (Color name) =
    class <| "has-text-" ++ name


size : Int -> Attribute msg
size n =
    class <| "is-" ++ String.fromInt n
