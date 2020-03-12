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

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- BASIC ELEMENTS


box : Builder msg
box =
    Html.div |> withMixins [ class "box" ]


button : Builder msg
button =
    Html.button |> withMixins [ class "button" ]


buttonAnchor : Builder msg
buttonAnchor =
    Html.a |> withMixins [ class "button" ]


linkAnchor : Builder msg
linkAnchor =
    Html.a |> withMixins [ class "link" ]


buttons : Builder msg
buttons =
    Html.div |> withMixins [ class "buttons" ]


content : Builder msg
content =
    Html.div |> withMixins [ class "content" ]


deleteButton : List (Attribute msg) -> Html msg
deleteButton attributes =
    Html.button (class "delete" :: attributes) []


deleteAnchor : List (Attribute msg) -> Html msg
deleteAnchor attributes =
    Html.a (class "delete" :: attributes) []


toDelete : Builder msg -> Builder msg
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
imageFigure : Builder msg
imageFigure =
    toImage Html.figure


toImage : Builder msg -> Builder msg
toImage =
    withMixins [ class "image" ]


notification : Builder msg
notification =
    Html.div |> withMixins [ class "notification" ]


progress : Builder msg
progress =
    Html.progress |> withMixins [ class "progress" ]


tableContainer : Builder msg
tableContainer =
    Html.div |> withMixins [ class "table-container" ]


table : Builder msg
table =
    Html.table |> withMixins [ class "table" ]


tag : Builder msg
tag =
    toTag Html.span


tags : Builder msg
tags =
    Html.div |> withMixins [ class "tags" ]


deleteTag : Builder msg
deleteTag =
    Html.a
        |> withMixins [ class "tag", class "is-delete" ]


toTag : Builder msg -> Builder msg
toTag =
    withMixins [ class "tag" ]


title : Builder msg
title =
    toTitle Html.h1


toTitle : Builder msg -> Builder msg
toTitle =
    withMixins [ class "title" ]


subtitle : Builder msg
subtitle =
    toSubtitle Html.span


toSubtitle : Builder msg -> Builder msg
toSubtitle =
    withMixins [ class "subtitle" ]
