module Main exposing (Model, init, main)

import Browser
import Bulma as B
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- INIT


type alias Model =
    ()


init : Model
init =
    ()



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Model -> Html msg
view model =
    B.section
        [ id "main" ]
        [ B.container
            []
            [ B.titleH1 [] "Hello!"
            , B.subtitleSpan [] "Bulma <3 Elm"
            ]
        ]
