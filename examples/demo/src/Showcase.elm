module Showcase exposing (main)

import Browser
import Capsule.Element as El
import Capsule.Columns as Col
import Capsule.Components.Tabs exposing (tabs)
import Capsule.Layout as Layout
import Capsule.Style as Style
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events



-- MAIN


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    Maybe Page


init : () -> ( Model, Cmd Msg )
init _ =
    ( Nothing
    , Cmd.none
    )


type Page
    = Box
    | Button


type Msg
    = ShowPage Page


update : Msg -> Model -> ( Model, Cmd Msg )
update (ShowPage page) _ =
    ( Just page
    , Cmd.none
    )


view : Model -> Browser.Document Msg
view model =
    { title = "Not happened"
    , body =
        [ viewTabs model
        , Layout.section []
            [ Layout.fluidContainer []
                [ globalColumn <|
                    [ case model of
                        Just page ->
                            viewWelcome

                        Nothing ->
                            viewWelcome
                    ]
                ]
            ]
        ]
    }


globalColumn : List (Html msg) -> Html msg
globalColumn children =
    Col.columns []
        [ Col.column
            [ Col.columnWidth Col.half
            , Col.withOffset (Col.oneQuarter)
            ]
            children
        ]



viewWelcome : Html msg
viewWelcome =
    El.content []
        [ El.title [] [ Html.text "Elm.Capsule" ]
        , El.subtitle [] [ Html.text "A package to let Elm play nicely with Bulma" ]
        ]


viewTabs : Maybe Page -> Html Msg
viewTabs maybePage =
    let
        tabTo page =
            let
                isActive =
                    if Just page == maybePage then
                        Style.active

                    else
                        Attributes.class ""
            in
            Html.li [ isActive ] <|
                [ Html.a
                    [ Events.onClick <| ShowPage page ]
                    [ Html.text <| pageToName page ]
                ]
    in
    tabs []
        [ Html.ul [] <|
            List.map tabTo pages
        ]


pages : List Page
pages =
    [ Box
    , Button
    ]


pageToName : Page -> String
pageToName page =
    case page of
        Box ->
            "Box"

        Button ->
            "Button"


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
