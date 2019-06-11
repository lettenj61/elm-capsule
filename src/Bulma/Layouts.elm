module Bulma.Layouts exposing (section)

import Html as H exposing (Attribute, Html)
import Html.Attributes as A


section : List (Attribute msg) -> List (Html msg) -> Html msg
section mods children =
    H.section ([ A.class "section" ] ++ mods) children
