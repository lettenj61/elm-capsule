module Capsule.Components.Panel exposing (..)


import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class, type_)


panel : Builder msg
panel =
    Html.nav |> withMixins [ class "panel" ]


panelHeading : Builder msg
panelHeading =
    Html.div |> withMixins [ class "panel-heading" ]


panelBlock : Builder msg
panelBlock =
    toPanelBlock Html.div


panelBlockAnchor : Builder msg
panelBlockAnchor =
    toPanelBlock Html.a


panelBlockCheckbox : Builder msg
panelBlockCheckbox attrs extras =
    let
        inner =
            Html.input (type_ "checkbox" :: attrs) []
    in
    toPanelBlock Html.label
        []
        ( inner :: extras )


toPanelBlock : Builder msg -> Builder msg
toPanelBlock =
    withMixins [ class "panel-block" ]


panelTabs : Builder msg
panelTabs =
    Html.div |> withMixins [ class "panel-tabs" ]


panelIcon : List (Attribute msg) -> String -> Html msg
panelIcon attributes iconClass =
    Html.span
        (class "panel-icon" :: attributes)
        [ Html.i [ class iconClass ] [] ]