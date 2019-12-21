module KitchenSink exposing (main)

import Browser
import Capsule.Columns as Column exposing (column, columnWidth, columns, half)
import Capsule.Components.Navbar exposing (..)
import Capsule.Components.Tabs exposing (tabs)
import Capsule.Element as El
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (color)
import Capsule.Style as Style
import Capsule.Types.Color as Color exposing (Color)
import Html exposing (Attribute, Html)
import Html.Attributes as Attributes
import Html.Events as Events



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- INIT


type alias Model =
    Maybe Example


type Example
    = Typography
    | Button


init : Model
init =
    Nothing


examples : List ( String, Example )
examples =
    [ ( "Typography", Typography )
    , ( "Button", Button )
    ]


basicColorMap : List ( String, Color )
basicColorMap =
    [ ( "Primary", Color.primary )
    , ( "Info", Color.info )
    , ( "Success", Color.success )
    , ( "Warning", Color.warning )
    , ( "Danger", Color.danger )
    , ( "Dark", Color.dark )
    , ( "Light", Color.light )
    , ( "Link", Color.link )
    ]



-- UPDATE


type Msg
    = Route Example


update : Msg -> Model -> Model
update (Route ex) =
    always (Just ex)



-- VIEW


type alias Detail msg =
    { title : String
    , subtitle : Maybe String
    , content : List (Html msg)
    }


view : Model -> Html Msg
view model =
    let
        detail =
            case model of
                Just ex ->
                    route ex

                Nothing ->
                    Detail "" Nothing []
    in
    Html.div [] <|
        viewNavbar :: viewTabs :: viewFromDetail detail


viewNavbar : Html msg
viewNavbar =
    navbar [ color Color.dark ]
        [ navbarBrand []
            [ navbarItem []
                [ Html.span
                    [ Attributes.style "font-weight" "600" ]
                    [ Html.text "Elm Capsule" ]
                ]
            , navbarBurger []
            ]
        , navbarMenu [ Style.active ]
            { defaultNavbarMenu
                | start =
                    [ navbarItemAnchor [] [ Html.text "Menu" ]
                    ]
            }
        ]


viewTabs : Html Msg
viewTabs =
    tabs []
        [ Html.ul [] <|
            List.map
                (\( labelString, ex ) ->
                    Html.li []
                        [ Html.a
                            [ Route ex |> Events.onClick ]
                            [ Html.text labelString ]
                        ]
                )
                examples
        ]


viewFromDetail : Detail msg -> List (Html msg)
viewFromDetail { title, subtitle, content } =
    let
        viewSubtitle =
            subtitle
                |> Maybe.map
                    (\val ->
                        El.subtitle [] [ Html.text val ]
                    )
                |> Maybe.withDefault (Html.text "")
    in
    [ Layout.hero [] <|
        List.concat
            [ [ El.title [] [ Html.text title ], viewSubtitle ]
            , content
            ]
    ]


viewTypographyExample : Detail msg
viewTypographyExample =
    Detail "Typography" Nothing []


viewButtonExample : Detail msg
viewButtonExample =
    let
        toButton mods ( el, colorName ) =
            El.button
                (color colorName :: mods)
                [ Html.text el ]

        pairsToHtml mods pairs =
            List.map (\pair -> toButton mods pair) pairs

        body =
            columns []
                [ column [ columnWidth half ]
                    [ El.buttons [] <| pairsToHtml [] basicColorMap
                    , El.buttons [] <| pairsToHtml [ Style.rounded ] basicColorMap
                    ]
                ]
    in
    { title = "Button", subtitle = Nothing, content = [ body ] }


route : Example -> Detail msg
route ex =
    case ex of
        Typography ->
            viewTypographyExample

        Button ->
            viewButtonExample



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
