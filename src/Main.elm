module Main exposing (main)

import Browser
import Capsule.Color exposing (danger, greyLighter, warning)
import Capsule.Element as Element
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (backgroundColor, color)
import Html exposing (Html)
import Html.Attributes exposing (class, style)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    Maybe String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Nothing
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html msg
view _ =
    Layout.section
        [ backgroundColor greyLighter
        , style "height" "100vh"
        ]
        [ viewContent ]


viewContent : Html msg
viewContent =
    Layout.container
        []
        [ Element.box
            [ class "is-radiusless" ]
            [ Html.text "Lorem ipsum" ]
        , Element.box
            []
            [ Html.p
                []
                [ Html.text "Impressed" ]
            , Element.button
                [ color danger ]
                [ Html.text "Give 100" ]
            ]
        , viewMedia
        , Element.notification
            [ color warning ]
            [ Html.text "You missed somethin'" ]
        ]


viewMedia : Html msg
viewMedia =
    let
        defaultMedia =
            Layout.defaultMedia
    in
    Layout.media
        []
        { defaultMedia
            | content =
                [ Element.content
                    []
                    [ Html.text "inside media" ]
                ]
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
