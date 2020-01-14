module KitchenSink exposing (main)

import Browser
import Capsule.Columns exposing (column, columnWidth, columns, half)
import Capsule.Components.Breadcrumb exposing (..)
import Capsule.Components.Menu exposing (..)
import Capsule.Components.Message exposing (..)
import Capsule.Components.Modal exposing (..)
import Capsule.Components.Navbar exposing (..)
import Capsule.Components.Tabs exposing (tabs)
import Capsule.Element as El
import Capsule.Forms as Forms
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
    , showModal : Bool
    }


type Example
    = Welcome
    | Typography
    | Button
    | Tags
    | Message
    | Modal
    | Navigations


init : Model
init =
    { example = Just Welcome
    , showModal = False
    }


examples : List ( String, Example )
examples =
    [ ( "Typography", Typography )
    , ( "Button", Button )
    , ( "Tags", Tags )
    , ( "Message", Message )
    , ( "Modal", Modal )
    , ( "Navigations", Navigations )
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
            { model | showModal = not model.showModal }



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
                    route ex model

                Nothing ->
                    route Welcome model

    in
    Html.div [] <|
        [ viewNavbar
        , viewTabs model
        ]
        ++ viewFromDetail detail


viewNavbar : Html Msg
viewNavbar =
    navbar [ color Color.dark ]
        [ navbarBrand
            []
            [ navbarItemAnchor
                [ Events.onClick <| Route Welcome
                ]
                [ Html.strong [] [ Html.text "Elm Capsule" ] ]
            , navbarBurger []
            ]
        , navbarMenu []
            defaultNavbarMenu
        ]


viewTabs : Model -> Html Msg
viewTabs { example } =
    tabs
        [ Style.marginless ]
        [ Html.ul [] <|
            List.map
                (\( labelString, ex ) ->
                    let
                        activeState =
                            if Just ex == example then
                                Style.active
                            else
                                Attributes.class ""
                    in
                    Html.li
                        [ activeState ]
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

        buttonStateRow text state =
            Html.tr []
                [ Html.td [] [ Html.text text ]
                , Html.td [] [ El.button [ state, color Color.success ] [ Html.text text ] ]
                ]

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
                    , sectionTitle "State"
                    , El.table
                        []
                        [ Html.thead [] []
                        , Html.tbody
                            []
                            [ buttonStateRow "loading" Style.loading
                            , buttonStateRow "focused" Style.focused
                            , buttonStateRow "hovered" Style.hovered
                            ]
                        ]
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

        toBadge labelString valueString colorName =
            Forms.control []
                [ El.tags
                    [ Style.hasAddons ]
                    [ El.tag [] [ Html.text labelString ]
                    , El.tag [ color colorName ] [ Html.text valueString ]
                    ]
                ]

        toDeletableTag labelString =
            Forms.control []
                [ El.tags
                    [ Style.hasAddons ]
                    [ El.tag [ color Color.dark ] [ Html.text labelString ]
                    , El.deleteTag [] []
                    ]
                ]

        exampleCols =
            columns []
                [ column [ columnSettings ]
                    [ El.tags [] <| List.map toTag basicColors
                    , Forms.multilineFieldGroup
                        []
                        [ toBadge "Task.succeed" "never" Color.danger
                        , toBadge "Time.every" "1000" Color.primary
                        ]
                    , Forms.multilineFieldGroup
                        []
                        [ toDeletableTag "Web"
                        , toDeletableTag "Virtual DOM"
                        , toDeletableTag "HTML5"
                        , toDeletableTag "Visualization"
                        , toDeletableTag "Ergonomics"
                        ]
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


viewModalExample : Model -> Detail Msg
viewModalExample { showModal } =
    { title = "Modal"
    , subtitle = Just "Your humble pop-up"
    , content =
        [ El.box [ Style.centered ]
            [ El.button
                [ Events.onClick ToggleModal
                , color Color.info
                ]
                [ Html.text "Show modal" ]
            ]
        , viewModal showModal
        ]
    }



viewModal : Bool -> Html Msg
viewModal showModal =
    modal
        [ if showModal then Style.active else Attributes.class "" ]
        [ modalBackground [ Attributes.style "opacity" "0.7", Events.onClick ToggleModal ] []
        , modalContent []
            [ El.notification [ color Color.success ]
                [ Html.text "inside a modal!" ]
            ]
        , modalClose [ Events.onClick ToggleModal ]
        ]


viewNavigationsExample : Detail msg
viewNavigationsExample =
    { title = "Navigations"
    , subtitle = Nothing
    , content = 
        [ column [ columnSettings ] <|
            viewBreadcrumbExample ++
            viewMenuExample
        ]
    }


viewBreadcrumbExample : List (Html msg)
viewBreadcrumbExample =
    let
        linkItem attrs linkText =
            Html.li
                attrs
                [ Html.a [] [ Html.text linkText ] ]
    in
    [ El.subtitle [] [ Html.text "Breadcrumb" ]
    , breadcrumb
        []
        [ linkItem [] "Usr"
        , linkItem [] "Local"
        , linkItem [ Style.active ] "Lib"
        ]
    , breadcrumb
        [ arrowSeparator ]
        [ linkItem [] "Get"
        , linkItem [] "Set"
        , linkItem [ Style.active ] "Launch"
        ]
    , breadcrumb
        [ bulletSeparator ]
        [ linkItem [] "Johnny"
        , linkItem [] "B"
        , linkItem [] "Goode"
        ]
    ]


viewMenuExample : List (Html msg)
viewMenuExample =
    let
        menuLink attrs linkText =
            Html.li attrs [ Html.a [] [ Html.text linkText] ]
    in
    [ El.subtitle [] [ Html.text "Menu" ]
    , menu []
        [ menuLabel [] [ Html.text "Control structure" ]
        , menuList []
            [ Html.li
                []
                [ Html.a [] [ Html.text "Control" ]
                , menuList []
                    [ menuLink [] "Control.Applicative"
                    , menuLink [] "Control.Monad"
                    ]
                ]
            , Html.li
                []
                [ Html.a [] [ Html.text "Data" ]
                , menuList []
                    [ menuLink [] "Data.Functor"
                    , menuLink [] "Data.Maybe"
                    ]
                ]
            ]
        ]
    ]


columnSettings : Attribute msg
columnSettings =
    Responsive.columnSet
        [ ( half, Breakpoint.desktop )
        ]


route : Example -> Model -> Detail Msg
route ex model =
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
            viewModalExample model

        Navigations ->
            viewNavigationsExample