module Bulma.Layout exposing (..)

import Bulma.Internal exposing (renderWhen, styled_)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)


{-| Wrap everything inside `section > .container`
-}
wrapper : List (Html msg) -> Html msg
wrapper children =
    Html.section
        [ class "section" ]
        [ Html.div
            [ class "container" ]
            children
        ]


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    styled_ Html.section "section"


container : List (Attribute msg) -> List (Html msg) -> Html msg
container =
    styled_ Html.div "container"


fluidContainer : List (Attribute msg) -> List (Html msg) -> Html msg
fluidContainer =
    styled_ Html.div "container is-fluid"


block : List (Attribute msg) -> List (Html msg) -> Html msg
block =
    styled_ Html.div "block"


hero : List (Attribute msg) -> List (Html msg) -> Html msg
hero attributes children =
    styled_ Html.div
        "hero"
        attributes
        [ Html.div
            [ class "hero-body" ]
            children
        ]


type alias MediaProps msg =
    { left : Maybe (Html msg)
    , right : Maybe (Html msg)
    , content : List (Html msg)
    }


media : MediaProps msg -> Html msg
media props =
    styled_ Html.article
        "media"
        []
        [ renderWhen props.left
        , Html.div [ class "media-content" ]
            props.content
        , renderWhen props.right
        ]


defaultMedia : MediaProps msg
defaultMedia =
    { left = Nothing
    , right = Nothing
    , content = []
    }


setMediaLeft : Html msg -> MediaProps msg -> MediaProps msg
setMediaLeft mediaLeft props =
    { props
        | left = Just mediaLeft
    }


setMediaRight : Html msg -> MediaProps msg -> MediaProps msg
setMediaRight mediaRight props =
    { props
        | right = Just mediaRight
    }


setMediaContent : List (Html msg) -> MediaProps msg -> MediaProps msg
setMediaContent content props =
    { props
        | content = content
    }


buttons : List (Attribute msg) -> List (Html msg) -> Html msg
buttons =
    styled_ Html.div "buttons"


tags : List (Attribute msg) -> List (Html msg) -> Html msg
tags =
    styled_ Html.div "tags"