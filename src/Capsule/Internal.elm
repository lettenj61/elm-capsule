module Capsule.Internal exposing (..)

import Html exposing (Attribute, Html)
import Html.Attributes as Attrs



-- HELPERS


type alias Tag msg =
    List (Attribute msg) -> List (Html msg) -> Html msg


wrap : List (Attribute msg) -> Tag msg -> Tag msg -> Tag msg
wrap defaults outer inner =
    \attrs children ->
        outer
            defaults
            [ inner attrs children
            ]


mixin : List (Attribute msg) -> Tag msg -> Tag msg
mixin defaults tag =
    \attrs children ->
        tag (defaults ++ attrs) children


defaultDiv : String -> Tag msg
defaultDiv className =
    Html.div |> mixin [ Attrs.class className ]
