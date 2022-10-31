module Bulma.Layout exposing
    ( container, fluidContainer
    , LevelProps, level, asLevelItem, mobileLevel, defaultLevel, setLevelLeft, setLevelRight
    , MediaProps, defaultMedia, media, setMediaContent, setMediaLeft, setMediaRight
    , hero
    , section
    , footer
    , wrapper
    )

{-| Bulma layout and wrapper classes.


# Container

@docs container, fluidContainer


# Level

@docs LevelProps, level, asLevelItem, mobileLevel, defaultLevel, setLevelLeft, setLevelRight


# Media object

@docs MediaProps, defaultMedia, media, setMediaContent, setMediaLeft, setMediaRight


# Hero

@docs hero


# Section

@docs section


# Footer

@docs footer


# Misc

@docs wrapper

-}

import Bulma.Internal exposing (renderWhen, styled_)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)


{-| Wrap everything inside `section > .container`

Shorthand to `section [] <| container`.

    import Bulma.Layout exposing (wrapper)
    import Html exposing (Html)

    myView : Html msg
    myView =
        wrapper
            [ Html.div
                []
                [ Html.text "In a container!" ]
            ]

-}
wrapper : List (Html msg) -> Html msg
wrapper children =
    Html.section
        [ class "section" ]
        [ Html.div
            [ class "container" ]
            children
        ]


{-| -}
section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    styled_ Html.section "section"


{-| -}
container : List (Attribute msg) -> List (Html msg) -> Html msg
container =
    styled_ Html.div "container"


{-| -}
fluidContainer : List (Attribute msg) -> List (Html msg) -> Html msg
fluidContainer =
    styled_ Html.div "container is-fluid"


{-| -}
type alias LevelProps msg =
    { left : List (Html msg)
    , right : List (Html msg)
    }


{-| -}
defaultLevel : LevelProps msg
defaultLevel =
    { left = []
    , right = []
    }


{-| -}
setLevelLeft : List (Html msg) -> LevelProps msg -> LevelProps msg
setLevelLeft levelLeft props =
    { props | left = levelLeft }


{-| -}
setLevelRight : List (Html msg) -> LevelProps msg -> LevelProps msg
setLevelRight levelRight props =
    { props | right = levelRight }


{-| -}
level : LevelProps msg -> Html msg
level props =
    Html.nav
        [ class "level" ]
        [ Html.div
            [ class "level-left" ]
            props.left
        , Html.div
            [ class "level-right" ]
            props.right
        ]


{-| -}
mobileLevel : List (Html msg) -> Html msg
mobileLevel children =
    Html.div
        [ class "level is-mobile" ]
        children


{-| -}
asLevelItem :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
asLevelItem h =
    styled_ h "level-item"


{-| -}
hero : List (Attribute msg) -> List (Html msg) -> Html msg
hero attributes children =
    styled_ Html.div
        "hero"
        attributes
        [ Html.div
            [ class "hero-body" ]
            children
        ]


{-| -}
type alias MediaProps msg =
    { left : Maybe (Html msg)
    , right : Maybe (Html msg)
    , content : List (Html msg)
    }


{-| -}
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


{-| -}
defaultMedia : MediaProps msg
defaultMedia =
    { left = Nothing
    , right = Nothing
    , content = []
    }


{-| -}
setMediaLeft : Html msg -> MediaProps msg -> MediaProps msg
setMediaLeft mediaLeft props =
    { props
        | left = Just mediaLeft
    }


{-| -}
setMediaRight : Html msg -> MediaProps msg -> MediaProps msg
setMediaRight mediaRight props =
    { props
        | right = Just mediaRight
    }


{-| -}
setMediaContent : List (Html msg) -> MediaProps msg -> MediaProps msg
setMediaContent content props =
    { props
        | content = content
    }


{-| -}
footer : List (Attribute msg) -> List (Html msg) -> Html msg
footer =
    styled_ Html.footer "footer"
