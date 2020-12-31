module Capsule.Layout exposing (..)

import Capsule.Internal exposing (Tag, defaultDiv, mixin, wrap)
import Html exposing (Attribute, Html)
import Html.Attributes as Attrs exposing (class)
import Html.Attributes exposing (default)



-- WRAPPERS


container : Tag msg
container =
    defaultDiv "container"


fluidContainer : Tag msg
fluidContainer =
    defaultDiv "container is-fluid"


section : Tag msg
section =
    Html.section |> mixin [ class "section" ]


hero : Tag msg
hero attrs children =
    Html.section
        (attrs ++ [class "hero"])
        [ defaultDiv "hero-body"
            []
            [ container [] children
            ]
        ]


type alias HeroDetail msg =
    { head : Html msg
    , body : List (Html msg)
    , foot : Html msg
    }


fullheightHero : List (Attribute msg) -> HeroDetail msg -> Html msg
fullheightHero attrs props =
    (Html.section |> mixin [class "hero"])
        attrs
        [ Html.div [class "hero-head"] [props.head]
        , Html.div [class "hero-body"] props.body
        , Html.div [class "hero-foot"] [props.foot]
        ]


-- EXPERIMENTS

