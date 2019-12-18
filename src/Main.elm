module Main exposing (main)

import Browser exposing (Document)
import Capsule.Color as Color exposing (danger, grey, primary, success, warning, whiteBis, whiteTer)
import Capsule.Element as Element
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (backgroundColor, color, textColor, sizeIs)
import Capsule.Size exposing (medium)
import Capsule.Style as Style
import Html exposing (Html)
import Html.Attributes exposing (class, style)



-- MAIN


main : Program () Model Msg
main =
    Browser.document
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


view : Model -> Document msg
view _ =
    { title = "Capsule"
    , body =
        [ viewHero
        , Element.notification
            [ color Color.dark, textColor whiteTer ]
            [ Html.text "alert" ]
        , Layout.section
            [ backgroundColor whiteBis
            , style "height" "100vh"
            ]
            [ viewContent
            ]
        ]
    }


viewHero : Html msg
viewHero =
    Layout.hero
        [ color primary
        , sizeIs medium
        , Style.bold
        ]
        [ Element.title [] [ Html.text "Hello" ]
        , Element.subtitle [] [ Html.text "Elm with Bulma!" ]
        ]


viewContent : Html msg
viewContent =
    Layout.container
        []
        [ Element.box
            [ Style.radiusless ]
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
            [ Html.text "You missed somethin'"
            , Element.deleteAnchor []
            ]
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
                    [ viewBadge "Money" "Welcome"
                    , viewBadge "Patience" "Worthless"
                    ]
                ]
        }


viewBadge : String -> String -> Html msg
viewBadge left right =
    Element.tags
        [ Style.hasAddons ]
        [ Element.tag [ color grey ] [ Html.text left ]
        , Element.tag [ color success ] [ Html.text right ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
