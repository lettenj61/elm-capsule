module Capsule.Element exposing
    ( box
    , button
    , buttonAnchor
    , buttons
    , content
    , deleteAnchor
    , deleteButton
    , deleteTag
    , icon
    , imageFigure
    , linkAnchor
    , notification
    , progress
    , subtitle
    , table
    , tableContainer
    , tag
    , tags
    , title
    , toDelete
    , toImage
    , toSubtitle
    , toTitle
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- BASIC ELEMENTS


box : Tagger msg
box =
    Html.div |> withMixins [ class "box" ]


button : Tagger msg
button =
    Html.button |> withMixins [ class "button" ]


buttonAnchor : Tagger msg
buttonAnchor =
    Html.a |> withMixins [ class "button" ]


linkAnchor : Tagger msg
linkAnchor =
    Html.a |> withMixins [ class "link" ]


buttons : Tagger msg
buttons =
    Html.div |> withMixins [ class "buttons" ]


content : Tagger msg
content =
    Html.div |> withMixins [ class "content" ]


deleteButton : List (Attribute msg) -> Html msg
deleteButton attributes =
    Html.button (class "delete" :: attributes) []


deleteAnchor : List (Attribute msg) -> Html msg
deleteAnchor attributes =
    Html.a (class "delete" :: attributes) []


toDelete : Tagger msg -> Tagger msg
toDelete =
    withMixins [ class "delete" ]


icon : List (Attribute msg) -> String -> Html msg
icon attributes iconClass =
    Html.span
        (class "icon" :: attributes)
        [ Html.i [ class iconClass ] [] ]


{-| A `figure` element as image container.

    import Capsule.Element exposing (image)
    import Html exposing (img)
    import Html.Attributes exposing (..)

    bestPic : Html msg
    bestPic =
        image
            [ class "is-4by3" ]
            [ img [ src "my-picture.png" ] [] ]

-}
imageFigure : Tagger msg
imageFigure =
    toImage Html.figure


toImage : Tagger msg -> Tagger msg
toImage =
    withMixins [ class "image" ]


notification : Tagger msg
notification =
    Html.div |> withMixins [ class "notification" ]


progress : Tagger msg
progress =
    Html.progress |> withMixins [ class "progress" ]


tableContainer : Tagger msg
tableContainer =
    Html.div |> withMixins [ class "table-container" ]


table : Tagger msg
table =
    Html.table |> withMixins [ class "table" ]


tag : Tagger msg
tag =
    toTag Html.span


tags : Tagger msg
tags =
    Html.div |> withMixins [ class "tags" ]


deleteTag : Tagger msg
deleteTag =
    Html.a
        |> withMixins [ class "tag", class "is-delete" ]


toTag : Tagger msg -> Tagger msg
toTag =
    withMixins [ class "tag" ]


title : Tagger msg
title =
    toTitle Html.h1


toTitle : Tagger msg -> Tagger msg
toTitle =
    withMixins [ class "title" ]


subtitle : Tagger msg
subtitle =
    toSubtitle Html.span


toSubtitle : Tagger msg -> Tagger msg
toSubtitle =
    withMixins [ class "subtitle" ]
