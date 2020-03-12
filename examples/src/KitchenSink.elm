module KitchenSink exposing (main)

import Browser
import Capsule.Columns exposing (column, columnWidth, columns, half)
import Capsule.Components.Breadcrumb exposing (..)
import Capsule.Components.Dropdown exposing (..)
import Capsule.Components.Menu exposing (..)
import Capsule.Components.Message exposing (..)
import Capsule.Components.Modal exposing (..)
import Capsule.Components.Navbar exposing (..)
import Capsule.Components.Panel exposing (..)
import Capsule.Components.Tabs exposing (tabs)
import Capsule.Element as El
import Capsule.Forms as Forms
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (..)
import Capsule.Responsive as Responsive
import Capsule.Types.Breakpoint as Breakpoint
import Capsule.Types.Color as Color exposing (Color)
import Capsule.Types.Size as Size exposing (Size)
import Capsule.Widget as UI
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
    | Form
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
    [ ( "Typography",   Typography )
    , ( "Button",       Button )
    , ( "Form",         Form )
    , ( "Tags",         Tags )
    , ( "Message",      Message )
    , ( "Modal",        Modal )
    , ( "Navigations",  Navigations )
    ]


basicColors : List ( String, Color )
basicColors =
    [ ( "Primary",  Color.primary )
    , ( "Info",     Color.info )
    , ( "Success",  Color.success )
    , ( "Warning",  Color.warning )
    , ( "Danger",   Color.danger )
    , ( "Dark",     Color.dark )
    , ( "Light",    Color.light )
    , ( "Link",     Color.link )
    ]


basicSizes : List ( String, Size )
basicSizes =
    [ ( "Normal",   Size.normal )
    , ( "Small",    Size.small )
    , ( "Medium",   Size.medium )
    , ( "Large",    Size.large )
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
        [ marginless ]
        [ Html.ul [] <|
            List.map
                (\( labelString, ex ) ->
                    let
                        activeState =
                            if Just ex == example then
                                active
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
                    (\val -> UI.subtitle [] val )
                |> Maybe.withDefault (Html.text "")

        viewDescription =
            [ UI.title [] title
            , viewSubtitle
            ]

    in
    [ Layout.hero [ color Color.light ] viewDescription
    , UI.section True content
    ] 


viewTypographyExample : Detail msg
viewTypographyExample =
    { title = "Typography"
    , subtitle = Nothing
    , content =
        [ UI.content
            [ UI.title [] "Header 1"
            , UI.subtitle [] "Description"
            , Html.p []
                [ Html.text "Content paragraph #1 "
                , Html.a [] [ Html.text "Link" ]
                ]
            , Html.ul []
                [ Html.li [] [ Html.text "List item 1" ]
                , Html.li [] [ Html.text "List item 2" ]
                ]
            ]
        ]
    }


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

        sectionTitle =
            UI.subtitle [ size <| Size.fromInt 5 ]

        buttonStateRow text state =
            Html.tr []
                [ Html.td [] [ Html.text text ]
                , Html.td [] [ El.button [ state, color Color.success ] [ Html.text text ] ]
                ]

        body =
            columns []
                [ column [ columnSettings ]
                    [ sectionTitle "Colors"
                    , UI.buttons [] <| pairsToHtml [] basicColors
                    , sectionTitle "Colors: light mode"
                    , UI.buttons [] <| pairsToHtml [ light ] basicColors
                    , sectionTitle "Rounded"
                    , UI.buttons [] <| pairsToHtml [ rounded ] basicColors
                    , sectionTitle "Sizes"
                    , UI.buttons [] <|
                        List.map
                            (\( text, val ) -> UI.button [ size val ] text )
                            basicSizes
                    , sectionTitle "State"
                    , El.table
                        []
                        [ Html.thead [] []
                        , Html.tbody
                            []
                            [ buttonStateRow "loading" loading
                            , buttonStateRow "focused" focused
                            , buttonStateRow "hovered" hovered
                            ]
                        ]
                    , sectionTitle "Dropdown"
                    , El.box
                        []
                        [ dropdown
                            [ hoverable ]
                            [ dropdownTrigger [] [ Html.text "Hover me" ]
                            , dropdownMenu []
                                [ dropdownAnchor [] [ Html.text "Link 1" ]
                                , dropdownAnchor [] [ Html.text "Link 2" ]
                                , dropdownAnchor [] [ Html.text "Link 3" ]
                                ]
                            ]
                        ]
                    ]
                ]
    in
    { title = "Button"
    , subtitle = Just "Common buttons with styles"
    , content = [ body ]
    }


viewFormExample : Detail msg
viewFormExample =
    let
        content =
            El.box
                []
                [ Forms.field []
                    [ Forms.control []
                        [ Forms.label [] [ Html.text "Description" ]
                        , Forms.input
                            [ Attributes.type_ "text"
                            , Attributes.placeholder "One upon a time ..."
                            ]
                            []
                        , Forms.help
                            []
                            [ Html.span [] [ Html.text "Charm your audience " ]
                            , Html.a [] [ Html.text "Learn more" ]
                            ]
                        ]
                    ]
                , Forms.fieldGroup []
                    [ Forms.control []
                        [ Forms.input [ Attributes.type_ "date" ] []
                        ]
                    , Forms.control []
                        [ El.button
                            [ color Color.primary ]
                            [ Html.text "Import" ]
                        ]
                    , Forms.control [ expanded ]
                        [ Forms.input
                            [ Attributes.placeholder "Post a comment" ]
                            []
                        ]
                    ]
                , Forms.field []
                    [ Forms.control []
                        [ Forms.textarea
                            [ color Color.primary
                            , Attributes.placeholder "What brings you here?"
                            ]
                            []
                        ]
                    ]
                ]
    in
    { title = "Form"
    , subtitle = Nothing
    , content = [ content ]
    }


viewTagsExample : Detail msg
viewTagsExample =
    let
        toTag ( text, colorName ) =
            El.tag [ color colorName ] [ Html.text text ]

        toBadge labelString valueString colorName =
            Forms.control []
                [ El.tags
                    [ hasAddons ]
                    [ El.tag [] [ Html.text labelString ]
                    , El.tag [ color colorName ] [ Html.text valueString ]
                    ]
                ]

        toDeletableTag labelString =
            Forms.control []
                [ El.tags
                    [ hasAddons ]
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
    , subtitle = Just "Small, versatile, informative tip"
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
        [ El.box [ centered ]
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
        [ if showModal then active else Attributes.class "" ]
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
        [ columns [] <|
            [ column [ columnSettings ] <|
                viewBreadcrumbExample ++
                viewMenuExample ++
                viewPanelExample
            ]
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
        , linkItem [ active ] "Lib"
        ]
    , breadcrumb
        [ arrowSeparator ]
        [ linkItem [] "Get"
        , linkItem [] "Set"
        , linkItem [ active ] "Launch"
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


viewPanelExample : List (Html msg)
viewPanelExample =
    [ panel
        [ color Color.link ]
        [ panelHeading [] [ Html.text "GUI" ]
        , panelBlock
            []
            [ El.button [ color Color.primary, inverted, fullwidth ] [ Html.text "Force Push" ] ]
        , panelTabs
            []
            ( List.map
                (\s -> Html.a [] [ Html.text s ])
                [ "Curry", "Turkey", "Fruit", "Yogurt" ]
            )
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

        Form ->
            viewFormExample
        
        Tags ->
            viewTagsExample

        Message ->
            viewMessageExample

        Modal ->
            viewModalExample model

        Navigations ->
            viewNavigationsExample