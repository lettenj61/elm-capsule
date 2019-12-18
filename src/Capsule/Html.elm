module Capsule.Html exposing
    ( Tagger
    , decorate
    , withMixins
    )

import Html exposing (Attribute, Html)



-- TAGGER


type alias Tagger msg =
    List (Attribute msg) -> List (Html msg) -> Html msg



-- DECORATIONS


decorate : Tagger msg -> List (Attribute msg) -> Tagger msg
decorate tagger mixins =
    withMixins mixins tagger


withMixins : List (Attribute msg) -> Tagger msg -> Tagger msg
withMixins mixins tagger =
    \attributes ->
        \children ->
            tagger (mixins ++ attributes) children
