module Capsule.Forms exposing
    ( checkbox
    , control
    , field
    , fieldGroup
    , input
    , label
    , multilineFieldGroup
    , radio
    , select
    , textarea
    , toControl
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html
import Html.Attributes exposing (class, type_)



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


{-| A checkbox wrapped inside label element.

I left it as normal tag function, because the events fired by
underlying input would be propagated through overwrapping labels.

Be warned that the label won't be modified by the attributes
passed to this function as the first argument.

    rememberMe =
        checkbox
            [ onClick RememberMe ]
            [ "Remember me" ]

renders to:

    <label class="checkbox">
        <input type="checkbox" onclick={RememberMe}>
        Remember me
    </label>
-}
checkbox : Tagger msg
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


radio : Tagger msg
radio attributes children =
    let
        underlying =
            Html.input
                ( type_ "radio" :: attributes )
                []
    in
    Html.label
        [ class "radio" ]
        (underlying :: children)

