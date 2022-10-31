module Bulma.Element exposing
    ( block
    , box
    , buttons, button, asButton
    , content
    , delete
    , Icon, icon
    , imageContainer
    , notification
    , progress
    , table, tableContainer
    , tags, tag, asTag
    , title, subtitle
    )

{-| Bulma elements.


# Block

@docs block


# Box

@docs box


# Button

@docs buttons, button, asButton


# Content

@docs content


# Delete

@docs delete


# Icon

@docs Icon, icon


# Image

@docs imageContainer


# Notification

@docs notification


# Progress bars

@docs progress


# Table

@docs table, tableContainer


# Tag

@docs tags, tag, asTag


# Title

@docs title, subtitle

-}

import Bulma.Internal exposing (styled_)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)


{-| -}
block : List (Attribute msg) -> List (Html msg) -> Html msg
block =
    styled_ Html.div "block"


{-| -}
box : List (Attribute msg) -> List (Html msg) -> Html msg
box =
    styled_ Html.div "box"


{-| -}
notification : List (Attribute msg) -> List (Html msg) -> Html msg
notification =
    styled_ Html.div "notification"


{-| -}
type alias Icon =
    { icon : String
    }


{-| -}
icon : List (Attribute msg) -> Icon -> Html msg
icon attributes props =
    styled_ Html.span
        "icon"
        attributes
        [ Html.i [ class props.icon ] []
        ]


{-| -}
title : List (Attribute msg) -> List (Html msg) -> Html msg
title =
    styled_ Html.h1 "title"


{-| -}
subtitle : List (Attribute msg) -> List (Html msg) -> Html msg
subtitle =
    styled_ Html.p "subtitle"


{-| -}
delete : List (Attribute msg) -> List (Html msg) -> Html msg
delete =
    styled_ Html.button "delete"


{-| -}
button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    styled_ Html.button "button"


{-| -}
asButton :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
asButton h =
    styled_ h "button"


{-| -}
buttons : List (Attribute msg) -> List (Html msg) -> Html msg
buttons =
    styled_ Html.div "buttons"


{-| -}
content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    styled_ Html.div "content"


{-| Style as `.tag` using given renderer
-}
asTag :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
asTag h =
    styled_ h "tag"


{-| -}
tag : List (Attribute msg) -> List (Html msg) -> Html msg
tag =
    asTag Html.span


{-| -}
tags : List (Attribute msg) -> List (Html msg) -> Html msg
tags =
    styled_ Html.div "tags"


{-| -}
imageContainer : List (Attribute msg) -> List (Html msg) -> Html msg
imageContainer =
    styled_ Html.figure "image"


{-| -}
progress : List (Attribute msg) -> List (Html msg) -> Html msg
progress =
    styled_ Html.progress "progress"


{-| -}
table : List (Attribute msg) -> List (Html msg) -> Html msg
table =
    styled_ Html.table "table"


{-| -}
tableContainer : List (Attribute msg) -> List (Html msg) -> Html msg
tableContainer =
    styled_ Html.div "table-container"
