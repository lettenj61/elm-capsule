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

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- CARD


card : Tagger msg
card =
    Html.div |> withMixins [ class "card" ]


cardImage : Tagger msg
cardImage =
    Html.div |> withMixins [ class "card-image" ]


cardContent : Tagger msg
cardContent =
    Html.div |> withMixins [ class "card-content" ]


cardFooter : Tagger msg
cardFooter =
    Html.footer |> withMixins [ class "card-footer" ]


cardFooterItem : Tagger msg
cardFooterItem =
    Html.p |> withMixins [ class "card-footer-item" ]


cardFooterLink : Tagger msg
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


cardHeaderTitle : Tagger msg
cardHeaderTitle =
    toCardHeaderTitle Html.p


toCardHeaderTitle : Tagger msg -> Tagger msg
toCardHeaderTitle =
    withMixins [ class "card-header-title" ]
