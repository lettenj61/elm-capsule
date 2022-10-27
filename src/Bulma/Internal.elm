module Bulma.Internal exposing (renderWhen, styled_)

import Html exposing (Attribute, Html)
import Html.Attributes as Attributes


renderWhen : Maybe (Html msg) -> Html msg
renderWhen maybeNode =
    maybeNode
        |> Maybe.withDefault (Html.text "")


styled_ :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> String
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
styled_ h className =
    \attributes children ->
        h (Attributes.class className :: attributes) children
