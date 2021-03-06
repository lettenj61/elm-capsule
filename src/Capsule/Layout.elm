module Capsule.Layout exposing
    ( ancestorTile
    , childTile
    , container
    , defaultMedia
    , fluidContainer
    , footer
    , fullheightHero
    , hero
    , level
    , levelItem
    , media
    , parentTile
    , section
    , tile
    , toContainer
    , toLevel
    , toLevelItem
    , toMedia
    )

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- LAYOUT ELEMENTS


container : Builder msg
container =
    toContainer Html.div


fluidContainer : Builder msg
fluidContainer =
    Html.div
        |> withMixins [ class "container", class "is-fluid" ]


toContainer : Builder msg -> Builder msg
toContainer =
    withMixins [ class "container" ]


section : Builder msg
section =
    Html.section |> withMixins [ class "section" ]



-- LEVEL


type alias LevelProps msg =
    { left : List (Html msg)
    , right : List (Html msg)
    }


level : List (Attribute msg) -> LevelProps msg -> Html msg
level =
    toLevel Html.nav


toLevel : Builder msg -> List (Attribute msg) -> LevelProps msg -> Html msg
toLevel builder attributes props =
    builder
        (class "level" :: attributes)
        [ Html.div [ class "level-left" ] props.left
        , Html.div [ class "level-right" ] props.right
        ]


levelItem : Builder msg
levelItem =
    toLevelItem Html.div


toLevelItem : Builder msg -> Builder msg
toLevelItem =
    withMixins [ class "level-item" ]



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


toMedia : Builder msg -> List (Attribute msg) -> MediaProps msg -> Html msg
toMedia builder attributes props =
    builder
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



-- HERO


type alias FullheightHeroProps msg =
    { navbar : List (Html msg)
    , content : List (Html msg)
    , foot : List (Html msg)
    }


hero : List (Attribute msg) -> List (Html msg) -> Html msg
hero attributes heroContent =
    Html.section
        (class "hero" :: attributes)
        [ Html.div
            [ class "hero-body" ]
            [ container [] heroContent
            ]
        ]


fullheightHero : List (Attribute msg) -> FullheightHeroProps msg -> Html msg
fullheightHero attributes props =
    Html.section
        (class "hero" :: attributes)
        [ Html.div [ class "hero-head" ] props.navbar
        , Html.div [ class "hero-body" ] props.content
        , Html.div [ class "hero-foot" ] props.foot
        ]



-- FOOTER


footer : Builder msg
footer =
    Html.footer |> withMixins [ class "footer" ]



-- TILES


tile : Builder msg
tile =
    Html.div |> withMixins [ class "tile" ]


ancestorTile : Builder msg
ancestorTile =
    Html.div |> withMixins [ class "tile", class "is-ancestor" ]


parentTile : Builder msg
parentTile =
    Html.div |> withMixins [ class "tile", class "is-parent" ]


childTile : Builder msg
childTile =
    Html.div |> withMixins [ class "tile", class "is-child" ]
