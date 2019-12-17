module Capsule.Html exposing
    ( Tagger
    , box
    )

import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- TAGGER


type alias Tagger msg =
    List (Attribute msg) -> List (Html msg) -> Html msg



-- BASIC ELEMENTS


box : Tagger msg
box =
    Html.div |> withMixins [ class "box" ]



-- WITH MIXINS


withMixins : List (Attribute msg) -> Tagger msg -> Tagger msg
withMixins mixins tagger =
    \attributes ->
        \children ->
            tagger (mixins ++ attributes) children
