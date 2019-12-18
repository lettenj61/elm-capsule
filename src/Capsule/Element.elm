module Capsule.Element exposing
    ( box
    , button
    , buttonAnchor
    , content
    , deleteAnchor
    , deleteButton
    , icon
    , image
    , notification
    , toDelete
    , toImage
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
    Html.a |> withMixins [ class "a" ]


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
image : Tagger msg
image =
    toImage Html.figure


toImage : Tagger msg -> Tagger msg
toImage =
    withMixins [ class "image" ]


notification : Tagger msg
notification =
    Html.div |> withMixins [ class "notification" ]
