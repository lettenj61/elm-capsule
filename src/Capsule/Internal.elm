module Capsule.Internal exposing (..)

import Html exposing (Attribute, Html)
import Html.Attributes as Attrs



-- HELPERS


type alias Tag msg =
    List (Attribute msg) -> List (Html msg) -> Html msg


mixin : List (Attribute msg) -> Tag msg -> Tag msg
mixin defaults tag =
    \attrs children ->
        tag (defaults ++ attrs) children


defaultDiv : String -> Tag msg
defaultDiv className =
    Html.div |> mixin [ Attrs.class className ]
