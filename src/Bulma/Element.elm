module Bulma.Element exposing (..)

import Bulma.Internal exposing (styled_)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)


box : List (Attribute msg) -> List (Html msg) -> Html msg
box =
    styled_ Html.div "box"


notification : List (Attribute msg) -> List (Html msg) -> Html msg
notification =
    styled_ Html.div "notification"


type alias Icon =
    { icon : String
    }


icon : List (Attribute msg) -> Icon -> Html msg
icon attributes props =
    styled_ Html.span
        "icon"
        attributes
        [ Html.i [ class props.icon ] []
        ]


title : List (Attribute msg) -> List (Html msg) -> Html msg
title =
    styled_ Html.h1 "title"


subtitle : List (Attribute msg) -> List (Html msg) -> Html msg
subtitle =
    styled_ Html.p "subtitle"


delete : List (Attribute msg) -> List (Html msg) -> Html msg
delete =
    styled_ Html.button "delete"


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    styled_ Html.button "button"


asButton :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
asButton h =
    styled_ h "button"


content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    styled_ Html.div "content"


{-| Simple wrapper which has class `.control`
-}
control : List (Attribute msg) -> List (Html msg) -> Html msg
control =
    styled_ Html.div "control"


{-| Style as `.tag` using given renderer
-}
asTag :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
asTag h =
    styled_ h "tag"


tag : List (Attribute msg) -> List (Html msg) -> Html msg
tag =
    asTag Html.span
