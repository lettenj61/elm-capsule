module Showcase.Element exposing (body)

import Capsule.Element as El
import Capsule.Modifiers as Mod
import Capsule.Types.Color as Color
import Html exposing (Html)


body : List (Html msg)
body =
    List.singleton <|
        El.button
            [ Mod.color Color.primary ]
            [ Html.text "Nothing" ]
