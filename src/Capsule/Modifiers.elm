module Capsule.Modifiers exposing
    ( backgroundColor
    , color
    , textColor
    )

import Capsule.Color exposing (Color)
import Capsule.Html.Internal exposing (toClass)
import Capsule.Html.Responsive as Responsive
import Html exposing (Attribute)



-- COLORS


backgroundColor : Color -> Attribute msg
backgroundColor =
    Responsive.backgroundColor >> toClass


color : Color -> Attribute msg
color =
    Responsive.color >> toClass


textColor : Color -> Attribute msg
textColor =
    Responsive.textColor >> toClass
