module KitchenSink exposing (main)

import Browser
import Capsule.Columns exposing (column, columnWidth, columns, half)
import Capsule.Components.Message exposing (..)
import Capsule.Components.Modal exposing (..)
import Capsule.Components.Navbar exposing (..)
import Capsule.Components.Tabs exposing (tabs)
import Capsule.Element as El
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (color, size)
import Capsule.Responsive as Responsive
import Capsule.Style as Style
import Capsule.Types.Breakpoint as Breakpoint
import Capsule.Types.Color as Color exposing (Color)
import Capsule.Types.Size as Size exposing (Size)
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
    { example : Maybe Example
    , widget : Widget
    }


type alias Widget =
    { showModal : Bool
    }


type Example
    = Welcome
    | Typography
    | Button
    | Tags
    | Message
    | Modal


init : Model
init =
    Model (Just Welcome) (Widget False)


examples : List ( String, Example )
examples =
    [ ( "Typography", Typography )
    , ( "Button", Button )
    , ( "Tags", Tags )
    , ( "Message", Message )
    , ( "Modal", Modal )
    ]


basicColors : List ( String, Color )
basicColors =
    [ ( "Primary", Color.primary )
    , ( "Info", Color.info )
    , ( "Success", Color.success )
    , ( "Warning", Color.warning )
    , ( "Danger", Color.danger )
    , ( "Dark", Color.dark )
    , ( "Light", Color.light )
    , ( "Link", Color.link )
    ]


basicSizes : List ( String, Size )
basicSizes =
    [ ( "Normal", Size.normal )
    , ( "Small", Size.small )
    , ( "Medium", Size.medium )
    , ( "Large", Size.large )
    ]



-- UPDATE


type Msg
    = Route Example
    | ToggleModal


update : Msg -> Model -> Model
update msg model =
    case msg of
        Route ex ->
            { model | example = Just ex }
        
        ToggleModal ->
            { example = model.example
            , widget =
                { showModal = not model.widget.showModal
                }
            }



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
            case model.example of
                Just ex ->
                    route ex model.widget

                Nothing ->
                    route Welcome model.widget

        cdnLink =
            Html.node "link"
                [ Attributes.rel "stylesheet"
                , Attributes.href "https://cdn.jsdelivr.net/npm/bulma@0.8.0/css/bulma.min.css"
                , Attributes.attribute "integrity" "sha256-D9M5yrVDqFlla7nlELDaYZIpXfFWDytQtiV+TaH6F1I="
                , Attributes.attribute "crossorigin" "anonymous"
                ]
                []
    in
    Html.div [] <|
        [ cdnLink
        , viewNavbar
        , viewTabs
        ]
        ++ viewFromDetail detail


viewNavbar : Html Msg
viewNavbar =
    navbar [ color Color.dark ]
        [ navbarBrand []
            [ navbarItemAnchor
                [ Events.onClick <| Route Welcome
                ]
                [ Html.text "Elm Capsule" ]
            , navbarBurger []
            ]
        , navbarMenu []
            defaultNavbarMenu
        ]


viewTabs : Html Msg
viewTabs =
    tabs [ Style.marginless ]
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

        viewDescription =
            [ El.title [] [ Html.text title ]
            , viewSubtitle
            ]
        
        viewDetailWrap =
            Layout.section []
                [ Layout.fluidContainer []
                    content
                ]
    in
    [ Layout.hero [ color Color.light ] viewDescription
    , viewDetailWrap
    ] 


viewTypographyExample : Detail msg
viewTypographyExample =
    Detail "Typography" Nothing []


viewButtonExample : Detail msg
viewButtonExample =
    let
        coloredButton mods ( el, colorName ) =
            El.button
                (color colorName :: mods)
                [ Html.text el ]

        pairsToHtml mods pairs =
            List.map
                (\pair -> coloredButton mods pair)
                pairs

        sectionTitle titleString =
            El.subtitle [ size <| Size.fromInt 5 ] [ Html.text titleString ]

        body =
            columns []
                [ column [ columnSettings ]
                    [ sectionTitle "Colors"
                    , El.buttons [] <| pairsToHtml [] basicColors
                    , sectionTitle "Colors: light mode"
                    , El.buttons [] <| pairsToHtml [ Style.light ] basicColors
                    , sectionTitle "Rounded"
                    , El.buttons [] <| pairsToHtml [ Style.rounded ] basicColors
                    , sectionTitle "Sizes"
                    , El.buttons [] <|
                        List.map
                            (\( text, val ) ->
                                El.button [ size val ] [ Html.text text ]
                            )
                            basicSizes
                    ]
                ]
    in
    { title = "Button"
    , subtitle = Just "Common buttons with styles"
    , content = [ body ]
    }


viewTagsExample : Detail msg
viewTagsExample =
    let
        toTag ( text, colorName ) =
            El.tag [ color colorName ] [ Html.text text ]

        exampleCols =
            columns []
                [ column [ columnSettings ]
                    [ El.tags [] <|
                        List.map toTag basicColors
                    ]
                ]
    in
    { title = "Tags"
    , subtitle = Just "Small, versatile, informative chip"
    , content = [ exampleCols ]
    }


viewMessageExample : Detail msg
viewMessageExample =
    let
        toLorem term =
            String.toLower term
                |> List.repeat 8
                |> String.join " .. "

        messageCard ( text, colorName ) =
            message [ color colorName ]
                [ messageHeader []
                    [ Html.p [] [ Html.text text ]
                    , El.deleteButton []
                    ]
                , messageBody []
                    [ Html.text <| toLorem text ]
                ]
    in
    { title = "Message"
    , subtitle = Just "Important notice to remember"
    , content =
        [ columns []
            [ column [ columnSettings ] <|
                List.map messageCard basicColors
            ]
        ]
    }


viewModalExample : Widget -> Detail Msg
viewModalExample { showModal } =
    { title = "Modal"
    , subtitle = Just "Your humble pop-up"
    , content =
        [ El.box [ Style.centered ]
            [ El.button
                [ Events.onClick ToggleModal
                , color Color.info
                , size Size.large
                ]
                [ Html.text "Show/Hide" ]
            ]
        , viewModal showModal
        ]
    }



viewModal : Bool -> Html Msg
viewModal showModal =
    modal
        [ if showModal then Style.active else Attributes.class "" ]
        [ modalBackground [ Events.onClick ToggleModal ] []
        , modalContent []
            [ El.notification [ color Color.success ]
                [ Html.text "inside a modal!" ]
            ]
        , modalClose [ Events.onClick ToggleModal ]
        ]


columnSettings : Attribute msg
columnSettings =
    Responsive.columnSet
        [ ( half, Breakpoint.desktop )
        ]


route : Example -> Widget -> Detail Msg
route ex widget =
    case ex of
        Welcome ->
            Detail "Welcome" (Just "Select samples from menu above!") []

        Typography ->
            viewTypographyExample

        Button ->
            viewButtonExample
        
        Tags ->
            viewTagsExample

        Message ->
            viewMessageExample

        Modal ->
            viewModalExample widget