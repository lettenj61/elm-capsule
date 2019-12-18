module Capsule.Layout exposing
    ( container
    , defaultMedia
    , media
    , section
    , toContainer
    , toMedia
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- LAYOUT ELEMENTS


container : Tagger msg
container =
    toContainer Html.div


toContainer : Tagger msg -> Tagger msg
toContainer =
    withMixins [ class "container" ]


section : Tagger msg
section =
    Html.section |> withMixins [ class "section" ]



-- MEDIA OBJECT


type alias MediaProps msg =
    { left : List (Html msg)
    , content : List (Html msg)
    , right : List (Html msg)
    }


defaultMedia : MediaProps msg
defaultMedia =
    MediaProps [] [] []


media : List (Attribute msg) -> MediaProps msg -> Html msg
media attributes props =
    toMedia Html.article attributes props


toMedia : Tagger msg -> List (Attribute msg) -> MediaProps msg -> Html msg
toMedia tagger attributes props =
    tagger
        (class "media" :: attributes)
        [ Html.div
            [ class "media-left" ]
            props.left
        , Html.div
            [ class "media-content" ]
            props.content
        , Html.div
            [ class "media-right" ]
            props.right
        ]
