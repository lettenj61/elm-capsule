module Capsule.Forms exposing (..)

import Capsule.Internal exposing (Tag, defaultDiv, mixin)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



control : Tag msg
control =
    defaultDiv "control"


field : Tag msg
field =
    defaultDiv "field"


fieldGroup : Tag msg
fieldGroup =
    defaultDiv "field is-grouped"


fieldWithAddons : Tag msg
fieldWithAddons =
    defaultDiv "field has-addons"


fieldLabel : Tag msg
fieldLabel =
    defaultDiv "field-label"


input : Tag msg
input =
    Html.input
        |> mixin
            [ class "input"
            ]


{-| Select element with wrappers

    import Capsule.Forms as Forms
    import Html
    import Html.Attributes exposing (..)

    view =
        Forms.select
            [ class "is-large" ]
            [ name "favorite-pets" ]
            [ Html.option [] [ Html.text "Dog" ]
            , Html.option [] [ Html.text "Cat" ]
            ]
-}
select : List (Attribute msg) -> Tag msg
select wrapperAttrs attrs options =
    Html.div
        wrapperAttrs
        [ Html.select attrs options
        ]


type alias HorizontalFieldDetail msg =
    { label : Html msg
    , body : Html msg
    }