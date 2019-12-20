module Main exposing (main)

import Browser exposing (Document)
import Capsule.Components.Card as Card
import Capsule.Columns exposing (column, columnWidth, columns, oneQuarter)
import Capsule.Element as El
import Capsule.Forms as Forms
import Capsule.Forms.Control as Control
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (color, size)
import Capsule.Style as Style
import Capsule.Types.Color exposing (dark, primary, success)
import Capsule.Types.Size exposing (large)
import Html exposing (Html, text)
import Html.Attributes as Attributes exposing (class, name, readonly, style, type_)
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



-- INIT


type Fruits
    = Apple
    | Banana
    | Grape


fruitsToString : Fruits -> String
fruitsToString fruit =
    case fruit of
        Apple ->
            "Apple"

        Banana ->
            "Banana"

        Grape ->
            "Grape"


type alias Model =
    { count : Int
    , fruits : Fruits
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0, fruits = Banana }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp
    | ClickedCheck
    | SetFruits Fruits


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ClickedCheck ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        SetFruits newFruits ->
            ( { model | fruits = newFruits }
            , Cmd.none
            )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Capsule"
    , body =
        [ viewHero
        , Layout.section
            []
            [ Layout.fluidContainer
                []
                [ viewContent model ]
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


viewContent : Model -> Html Msg
viewContent model =
    columns
        []
        [ column
            [ columnWidth oneQuarter ]
            [ Html.p []
                [ Html.text <| "clicked: " ++ String.fromInt model.count ]
            , Html.p []
                [ Html.text <| fruitsToString model.fruits ]
            , viewCard
            ]
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
                        [ type_ "text"
                        , readonly True
                        ]
                        []
                    ]
                ]
            , Forms.field []
                [ Forms.control []
                    [ Forms.checkbox
                        [ Events.onClick ClickedCheck ]
                        [ Html.text " Send me a newsletter" ]
                    ]
                ]
            , viewFruitsSwitcher
                [ ( "Yellow", Banana )
                , ( "Red", Apple )
                , ( "Purple", Grape )
                ]
            ]
        ]


viewFruitsSwitcher : List ( String, Fruits ) -> Html Msg
viewFruitsSwitcher pairs =
    let
        switcher ( colorName, fruits ) =
            Forms.radio
                [ Events.onClick <| SetFruits fruits
                , name "fruits"
                ]
                [ Html.text colorName ]
    in
    Forms.field []
        [ Forms.control [] <| List.map switcher pairs
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


viewCard : Html msg
viewCard =
    Card.card []
        [ Card.cardHeader []
            { title =
                Card.cardHeaderTitle []
                    [ Html.text "Growing life"]
            , icon = Nothing
            }
        , Card.cardContent []
            [ El.content []
                [ Html.text "Stub" ]
            ]
        ]


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
