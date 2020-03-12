module Capsule.Forms exposing
    ( checkbox
    , control
    , field
    , fieldBody
    , fieldGroup
    , fieldLabel
    , help
    , input
    , label
    , multilineFieldGroup
    , radio
    , select
    , selectWith
    , textarea
    , toControl
    )

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute)
import Html.Attributes exposing (class, type_)



-- FIELDS


field : Builder msg
field =
    Html.div |> withMixins [ class "field" ]


fieldGroup : Builder msg
fieldGroup =
    Html.div |> withMixins [ class "field", class "is-grouped" ]


multilineFieldGroup : Builder msg
multilineFieldGroup =
    Html.div
        |> withMixins [ class "field", class "is-grouped", class "is-grouped-multiline" ]


label : Builder msg
label =
    Html.label |> withMixins [ class "label" ]


control : Builder msg
control =
    toControl Html.div


toControl : Builder msg -> Builder msg
toControl =
    withMixins [ class "control" ]



-- INDIVIDUAL CONTROLS


input : Builder msg
input =
    Html.input |> withMixins [ class "input" ]


{-| A select element wrapped in special div.

    import Capsule.Forms exposing (control, field, select)
    import Capsule.Modifiers exposing (..)
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
select : Builder msg
select =
    selectWith []


selectWith : List (Attribute msg) -> Builder msg
selectWith outerFacts attributes children =
    Html.div
        (class "select" :: outerFacts)
        [ Html.select attributes children
        ]


textarea : Builder msg
textarea =
    Html.textarea |> withMixins [ class "textarea" ]


{-| A checkbox wrapped inside label element.

I left it as normal tag function, because the events fired by
underlying input would be propagated through overwrapping labels.

Be warned that the label won't be modified by the attributes
passed to this function as the first argument.

    rememberMe =
        checkbox
            [ onClick RememberMe ]
            [ text "Remember me" ]

renders to:

    <label class="checkbox">
        <input type="checkbox" onclick={RememberMe}>
        Remember me
    </label>

-}
checkbox : Builder msg
checkbox attributes children =
    let
        underlying =
            Html.input
                (type_ "checkbox" :: attributes)
                []
    in
    Html.label
        [ class "checkbox" ]
        (underlying :: children)


radio : Builder msg
radio attributes children =
    let
        underlying =
            Html.input
                (type_ "radio" :: attributes)
                []
    in
    Html.label
        [ class "radio" ]
        (underlying :: children)



-- OPTIONAL HELP TEXT


help : Builder msg
help =
    Html.p |> withMixins [ class "help" ]



-- HORIZONTAL FIELD


fieldLabel : Builder msg
fieldLabel =
    Html.div |> withMixins [ class "field-label" ]


fieldBody : Builder msg
fieldBody =
    Html.div |> withMixins [ class "field-body" ]
