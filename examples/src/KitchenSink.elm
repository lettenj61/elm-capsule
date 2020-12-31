module KitchenSink exposing (main)

import Capsule.Layout as Layout
import Capsule.Widgets as UI
import Html exposing (Html)
import Html.Attributes exposing (..)


main : Html msg
main =
    layout
        [ UI.buttons
            [ class "are-large"
            ]
            [ myButton "is-primary is-radiusless" "PUSH"
            ]
        , UI.box
            []
            [ UI.content
                []
                [ Html.p [] [Html.text "Hi"]
                ]
            ]
        ]


myButton : String -> String -> Html msg
myButton extras label =
    UI.button [ class extras ] [ Html.text label ]


layout : List (Html msg) -> Html msg
layout children =
    Layout.section []
        [ Layout.fluidContainer
            []
            children
        ]

