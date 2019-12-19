module Capsule.Forms exposing
    ( checkbox
    , control
    , field
    , fieldGroup
    , input
    , label
    , multilineFieldGroup
    , select
    , textarea
    , toControl
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- FIELDS


field : Tagger msg
field =
    Html.div |> withMixins [ class "field" ]


fieldGroup : Tagger msg
fieldGroup =
    Html.div |> withMixins [ class "field", class "is-grouped" ]


multilineFieldGroup : Tagger msg
multilineFieldGroup =
    Html.div
        |> withMixins [ class "field", class "is-grouped", class "is-grouped-multiline" ]


label : Tagger msg
label =
    Html.label |> withMixins [ class "label" ]


control : Tagger msg
control =
    toControl Html.div


toControl : Tagger msg -> Tagger msg
toControl =
    withMixins [ class "control" ]



-- INDIVIDUAL CONTROLS


input : Tagger msg
input =
    Html.input |> withMixins [ class "input" ]


{-| A select element wrapped in special div.

    import Capsule.Forms exposing (control, field, select)
    import Capsule.Style exposing (..)
    import Html exposing (Html, option, text)

    view : Html msg
    view =
        field []
            [ control []
                [ select []
                    [ option [] [ text "A" ]
                    , option [] [ text "B" ]
                    , option [] [ text "C" ]
                    ]
                ]
            ]

-}
select : Tagger msg
select attributes children =
    Html.div
        [ class "select" ]
        [ Html.select
            attributes
            children
        ]


textarea : Tagger msg
textarea =
    Html.textarea |> withMixins [ class "textarea" ]


checkbox : List (Attribute msg) -> Tagger msg
checkbox innerAttributes attributes children =
    let
        underlying =
            Html.input
                (class "checkbox" :: innerAttributes)
                []
    in
    label
        attributes
        (underlying :: children)
