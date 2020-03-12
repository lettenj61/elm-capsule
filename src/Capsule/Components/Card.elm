module Capsule.Components.Card exposing
    ( card
    , cardContent
    , cardFooter
    , cardFooterItem
    , cardFooterLink
    , cardHeader
    , cardHeaderTitle
    , cardImage
    , toCardHeaderTitle
    )

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- CARD


card : Builder msg
card =
    Html.div |> withMixins [ class "card" ]


cardImage : Builder msg
cardImage =
    Html.div |> withMixins [ class "card-image" ]


cardContent : Builder msg
cardContent =
    Html.div |> withMixins [ class "card-content" ]


cardFooter : Builder msg
cardFooter =
    Html.footer |> withMixins [ class "card-footer" ]


cardFooterItem : Builder msg
cardFooterItem =
    Html.p |> withMixins [ class "card-footer-item" ]


cardFooterLink : Builder msg
cardFooterLink =
    Html.a |> withMixins [ class "card-footer-item" ]



-- CARD HEADER


type alias CardHeaderProps msg =
    { title : Html msg
    , icon : Maybe (Html msg)
    }


cardHeader : List (Attribute msg) -> CardHeaderProps msg -> Html msg
cardHeader attributes props =
    Html.header (class "card-header" :: attributes)
        [ props.title
        , case props.icon of
            Just icon ->
                Html.a
                    [ class "card-header-icon" ]
                    [ icon ]

            Nothing ->
                Html.text ""
        ]


cardHeaderTitle : Builder msg
cardHeaderTitle =
    toCardHeaderTitle Html.p


toCardHeaderTitle : Builder msg -> Builder msg
toCardHeaderTitle =
    withMixins [ class "card-header-title" ]
