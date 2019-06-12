module Bulma.Media exposing (Media, media_)

import Bulma.Internal exposing (Attrs, Children, liftTree)
import Html as H exposing (Attribute, Html)
import Html.Attributes exposing (class)


type alias Media msg =
    { left : Children msg
    , content : Children msg
    , right : Children msg
    }


mediaOptions : Media msg
mediaOptions =
    { left = []
    , content = []
    , right = []
    }


media : Attrs msg -> Media msg -> Html msg
media =
    media_ "div"


media_ : String -> Attrs msg -> Media msg -> Html msg
media_ tagName attrs options =
    let
        { left, content, right } =
            options

        tag =
            H.node tagName

        subTree =
            List.concat
                [ liftTree "media-left" H.div left
                , liftTree "media-content" H.div content
                , liftTree "media-right" H.div right
                ]
    in
    tag
        ([ class "media" ] ++ attrs)
        subTree
