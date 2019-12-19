module Main exposing (main)

import Browser exposing (Document)
import Capsule.Columns exposing (column, columnWidth, columns, half, oneQuarter)
import Capsule.Element as El
import Capsule.Forms as Forms
import Capsule.Forms.Control as Control
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (backgroundColor, color, size, textColor)
import Capsule.Style as Style
import Capsule.Types.Color exposing (dark, primary, success)
import Capsule.Types.Size exposing (medium)
import Html exposing (Html, text)
import Html.Attributes as Attributes exposing (class, readonly, style, type_)



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
        , Layout.section
            []
            [ Layout.fluidContainer
                []
                [ viewContent ]
            ]
        ]
    }


viewHero : Html msg
viewHero =
    Layout.hero
        [ color dark
        ]
        [ El.title [] [ Html.text "Hello" ]
        , El.subtitle [] [ Html.text "Elm with Bulma!" ]
        ]


viewContent : Html msg
viewContent =
    columns
        []
        [ column
            [ columnWidth oneQuarter ]
            [ Html.p [] [ Html.text "first" ] ]
        , column
            [{- auto -}]
            [ El.content []
                [ Html.a
                    [ Attributes.href "#" ]
                    [ text "second" ]
                ]
            , Forms.multilineFieldGroup []
                (viewBadges
                    [ ( "CI"        , "Passed"          )
                    , ( "Package"   , "1.0.7"           )
                    , ( "Coverage"  , "96%"             )
                    , ( "Price"     , "$14.99"          )
                    , ( "Atomicity" , "Not Preserved"   )
                    , ( "Metascore" , "87.0"            )
                    ]
                )
            , Forms.field []
                [ Forms.label [] [ Html.text "Name" ]
                , Forms.control [ Style.loading ]
                    [ Forms.input
                        [ type_ "date"
                        , readonly True
                        , color primary
                        ]
                        []
                    ]
                ]
            ]
        ]


viewBadges : List ( String, String ) -> List (Html msg)
viewBadges labelledTexts =
    List.map (\( l, r ) -> viewBadge l r) labelledTexts


viewBadge : String -> String -> Html msg
viewBadge left right =
    Control.fromAttributes []
        |> Control.setInput
            (El.tags
                [ Style.hasAddons ]
                [ El.tag [ color dark ] [ text left ]
                , El.tag [ color success ] [ text right ]
                ]
            )
        |> Control.build



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
