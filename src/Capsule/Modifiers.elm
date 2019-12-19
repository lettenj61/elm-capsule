module Capsule.Modifiers exposing
    ( backgroundColor
    , color
    , textColor
    , size
    )

import Capsule.Types.Color as Color exposing (Color)
import Capsule.Types.Size as Size exposing (Size)
import Html exposing (Attribute)
import Html.Attributes exposing (class)



-- COLORS


backgroundColor : Color -> Attribute msg
backgroundColor name =
    class <| "has-background-" ++ Color.toString name


color : Color -> Attribute msg
color name =
    class <| "is-" ++ Color.toString name


textColor : Color -> Attribute msg
textColor name =
    class <| "has-text-" ++ Color.toString name


size : Size -> Attribute msg
size name =
    class <| "is-" ++ Size.toString name
