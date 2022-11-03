module KitchenSink exposing (main)

import Browser
import Bulma.Columns as Columns
import Bulma.Complex as Widget
import Bulma.Element as El
import Bulma.Form as Form
import Bulma.Layout as Layout
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, id)
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
    { burgerMenu : Bool
    , dropdowns : Dict Int Bool
    }


init : Model
init =
    { burgerMenu = False
    , dropdowns = Dict.fromList []
    }



-- UPDATE


type Msg
    = NoOp
    | ToggleBurger
    | ToggleDropdownAt Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        ToggleBurger ->
            { model
                | burgerMenu = not model.burgerMenu
            }

        ToggleDropdownAt dropdown ->
            model
                |> toggleDropdownState dropdown


getDropdownState : Int -> Model -> Bool
getDropdownState dropdownId { dropdowns } =
    dropdowns
        |> Dict.get dropdownId
        |> Maybe.withDefault False


toggleDropdownState : Int -> Model -> Model
toggleDropdownState dropdownId model =
    { model
        | dropdowns =
            let
                newState =
                    not <|
                        getDropdownState dropdownId model
            in
            Dict.insert dropdownId newState model.dropdowns
    }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewHeader model.burgerMenu
        , viewMain
            [ viewMedia
            , viewButtons
            , viewCard
            , viewDropdowns model
            , viewSelectVariants
            , viewTabs
            , viewMessagesVariants
            , viewPagination
            ]
        ]


viewHeader : Bool -> Html Msg
viewHeader isMenuActive =
    header []
        [ Widget.navbarWithMenu [ class "is-fixed-top is-dark has-shadow" ]
            (Widget.defaultNavbar
                |> Widget.setNavbarBrand
                    { logo =
                        Widget.navbarItem div
                            [ class "has-text-weight-bold"
                            ]
                            [ text "Logo" ]
                    , burger =
                        [ Events.onClick ToggleBurger
                        ]
                    }
                |> Widget.setNavbarMenuOptions
                    [ class <|
                        if isMenuActive then
                            "is-active"

                        else
                            ""
                    ]
                |> Widget.setNavbarStart
                    [ Widget.navbarItem a
                        [ href "#" ]
                        [ text "Home" ]
                    ]
            )
        ]


viewMain : List (Html msg) -> Html msg
viewMain children =
    main_
        [ class "mt-4"
        , id "top"
        ]
        [ Layout.fluidContainer []
            [ Columns.row
                []
                [ Columns.column
                    [ class "is-3-tablet" ]
                    [ viewSidebar ]
                , Columns.column
                    []
                    children
                ]
            ]
        ]


viewSidebar : Html msg
viewSidebar =
    Widget.menu []
        [ Widget.menuLabel [] [ text "Menu" ]
        , Widget.menuList []
            [ Widget.menuAnchorItem
                [ href "#top" ]
                [ text "Top" ]
            , Widget.menuAnchorItem
                [ href "#media-object" ]
                [ text "Media" ]
            , Widget.menuAnchorItem
                [ href "#buttons" ]
                [ text "Button" ]
            ]
        ]


viewMedia : Html msg
viewMedia =
    let
        sampleTexts =
            [ "そのうち、第一種の幽霊、狐狸等は、人身の外部に現存し、あるいは外界に現見するものにして、たとい精神作用より発するにもせよ、夢および巫覡等と異なるところあれば、しばらくその一種を別置するなり。第二種は、他人ありてわが心身の事情変化を考定審判するものにして、神を降ろす術、狐をつける法、人相、家相、九星、方位、干支、卜筮等、みなこれに属す。察心とは、人の心を察知する術、催眠とは、人為によりて人の眠りを催起する術なり。"
            , "かくのごとき魔法、幻術に類するもの、世間はなはだ多し。第三種は、人の媒介をまたずして自己の身心上に発するものにして、夢のごとく夜行のごときこれなり。"
            , "夜行とは夢中の動作を義とし、睡眠中、あるいは言語を発し、あるいは起座し、あるいは歩行して、自らなにも知覚せざるがごときものをいう。"
            , "神感とは、自然に神の感通告示ありて、遠路のことを感知し、あるいは未来のことを予知するの類をいい、神知とは、教育を受けず、経験に接せずして、自然に種々のことを知るの類をいう。例えば、二、三歳の子供が書をよくし字を知り、下女が論語を読むがごとき、これ神知の一種なり。"
            ]

        articleBody bodyText =
            Layout.defaultMedia
                |> Layout.setMediaContent
                    [ El.content []
                        [ p [] [ text bodyText ]
                        ]
                    ]
    in
    renderShowcase
        [ id "media-object" ]
        { subtitle = "Media"
        , contents =
            sampleTexts
                |> List.map (Layout.media << articleBody)
        }


viewButtons : Html msg
viewButtons =
    renderShowcase [ id "buttons" ]
        { subtitle = "Button"
        , contents =
            [ El.buttons [ class "are-medium" ]
                (basicColors
                    |> List.map
                        (\colorName ->
                            El.button
                                [ toIsModifier colorName ]
                                [ text colorName ]
                        )
                )
            , El.buttons [ class "are-medium" ]
                (basicColors
                    |> List.map
                        (\colorName ->
                            El.button
                                [ toIsModifier colorName
                                , class "is-inverted"
                                ]
                                [ text colorName ]
                        )
                )
            , El.buttons [ class "are-medium" ]
                (basicColors
                    |> List.map
                        (\colorName ->
                            El.button
                                [ toIsModifier colorName
                                , class "is-outlined"
                                ]
                                [ text colorName ]
                        )
                )
            ]
        }


viewSelectVariants : Html msg
viewSelectVariants =
    renderShowcase [ id "select" ]
        { subtitle = "Select"
        , contents =
            List.map
                (\sizeName ->
                    Form.field
                        []
                        [ Form.control []
                            [ Form.select
                                { wrapper = [ toIsModifier sizeName ]
                                , inner = []
                                , options =
                                    [ optgroup
                                        [ attribute "label" sizeName ]
                                        (List.map
                                            (\str -> option [] [ text str ])
                                            [ "JavaScript"
                                            , "TypeScript"
                                            , "CoffeeScript"
                                            , "ReScript"
                                            , "PureScript"
                                            , "Elm"
                                            ]
                                        )
                                    ]
                                }
                            ]
                        ]
                )
                basicSizes
        }


viewMessagesVariants : Html msg
viewMessagesVariants =
    renderShowcase [ id "message" ]
        { subtitle = "Message"
        , contents =
            List.map
                (\colorName ->
                    Widget.message
                        [ toIsModifier colorName ]
                        (Widget.defaultMessage
                            |> Widget.setMessageBody
                                [ p []
                                    [ text "Stet stet consequat sit et gubergren ut. Ut ex at labore nonumy at diam dolor kasd erat diam et erat consetetur duis. Lorem kasd et lorem diam delenit ad labore et sadipscing illum in amet eum ipsum kasd et ullamcorper. Eos stet nonumy consetetur qui stet ipsum autem sit. Gubergren zzril consequat stet quod feugiat sanctus sadipscing sed nulla dolor diam. Ea minim dolore autem. Dolore magna erat amet tempor duo. Aliquyam nobis dolores et ipsum sit et duo magna at vero amet. Euismod duo elitr. Ut dolor magna et et sea stet. Lobortis labore amet enim eum ullamcorper sit labore lorem stet diam diam kasd voluptua at invidunt eos consectetuer et. Eu volutpat elitr magna nonumy sit aliquyam dolore erat amet gubergren consetetur ipsum no eum amet adipiscing odio tempor. Magna kasd hendrerit." ]
                                ]
                        )
                )
                basicColors
        }


viewPagination : Html msg
viewPagination =
    renderShowcase
        []
        { subtitle = "Pagination"
        , contents =
            [ Widget.defaultPagination
                |> Widget.setPaginationList
                    (Widget.paginationEllipsis [] [ text "..." ]
                        :: List.map
                            (\number ->
                                Widget.paginationLink (number == 2)
                                    [ href "" ]
                                    [ text <| String.fromInt number ]
                            )
                            [ 1, 2, 3, 4 ]
                    )
                |> Widget.pagination
            ]
        }


viewDropdowns : Model -> Html Msg
viewDropdowns model =
    renderShowcase
        []
        { subtitle = "Dropdowns"
        , contents =
            [ Widget.dropdown
                (getDropdownState 1 model)
                [ class "mx-2" ]
                (Widget.defaultDropdown
                    |> Widget.setDropdownTrigger
                        (El.asButton a
                            [ class "is-danger is-light"
                            , Events.onClick <| ToggleDropdownAt 1
                            ]
                            [ text "Expand It" ]
                        )
                    |> Widget.setDropdownContent
                        [ Widget.dropdownItem div
                            []
                            [ p [] [ text "Inner content" ]
                            ]
                        ]
                )
            , Widget.dropdown
                False
                [ class "is-hoverable mx-2" ]
                (Widget.defaultDropdown
                    |> Widget.setDropdownTrigger
                        (El.asButton a
                            []
                            [ text "Hover Me" ]
                        )
                    |> Widget.setDropdownContent
                        [ Widget.dropdownItem div
                            []
                            [ p [] [ text "You got me." ]
                            ]
                        ]
                )
            , Widget.dropdown
                (getDropdownState 3 model)
                []
                (Widget.defaultDropdown
                    |> Widget.setDropdownTrigger
                        (El.asButton a
                            [ class "is-primary is-outlined"
                            , Events.onMouseEnter <| ToggleDropdownAt 3
                            , Events.onMouseLeave <| ToggleDropdownAt 3
                            ]
                            [ text "More Content" ]
                        )
                    |> Widget.setDropdownContent
                        [ Widget.dropdownItem div
                            []
                            [ p [] [ text "Coming early 2027." ]
                            , p [] [ text "Get ready for this AAA title" ]
                            ]
                        ]
                )
            ]
        }


viewTabs : Html msg
viewTabs =
    renderShowcase
        [ id "tabs" ]
        { subtitle = "Tabs"
        , contents =
            [ Widget.tabs
                []
                (List.map
                    (\labelText ->
                        Widget.tabItem False
                            []
                            [ text labelText ]
                    )
                    [ "Play", "Stop", "Rewind" ]
                )
            ]
        }


viewCard : Html msg
viewCard =
    renderShowcase
        []
        { subtitle = "Cards"
        , contents =
            [ Widget.card
                (Widget.defaultCard
                    |> Widget.setCardHeader
                        { title =
                            Widget.cardHeaderTitle []
                                [ text "Example title" ]
                        , icon = Nothing
                        }
                    |> Widget.setCardImage
                        { figure =
                            [ class "image is-4by3"
                            , class "has-background-primary"
                            ]
                        , image = []
                        }
                    |> Widget.setCardContent
                        [ El.title [ class "is-4" ] [ text "Author Name" ]
                        , El.subtitle [ class "is-6" ] [ text "@example" ]
                        , El.content []
                            [ p []
                                [ text "Dolores clita stet diam euismod ipsum nonumy lorem sadipscing accusam takimata sed diam nonumy sanctus. Tempor autem diam qui amet blandit vulputate et et. Elitr takimata sea dolore zzril. Velit eos te et diam accusam facilisi erat aliquyam gubergren. Stet diam ipsum takimata amet vero justo ut est nostrud ea kasd consequat eos zzril justo magna accumsan et. In sanctus ad aliquam lobortis blandit exerci. Ea elitr sadipscing no diam blandit voluptua euismod et consetetur sit. Diam ipsum gubergren ipsum et dolore sed no sed invidunt duo lorem dolores ea diam nulla sit. Dolore sed duo nibh et rebum luptatum illum odio nulla aliquyam sed ipsum consetetur."
                                ]
                            ]
                        ]
                    |> Widget.setCardFooter
                        [ Widget.cardFooterItem
                            [ href "#"
                            ]
                            [ text "Reply" ]
                        , Widget.cardFooterItem
                            [ href "#"
                            ]
                            [ text "Share" ]
                        , Widget.cardFooterItem
                            [ href "#"
                            ]
                            [ text "Like" ]
                        ]
                )
            ]
        }


type alias Showcase msg =
    { subtitle : String
    , contents : List (Html msg)
    }


renderShowcase : List (Attribute msg) -> Showcase msg -> Html msg
renderShowcase facts props =
    Layout.section facts
        (El.subtitle [] [ text props.subtitle ]
            :: props.contents
        )


basicColors : List String
basicColors =
    [ "Primary"
    , "Info"
    , "Link"
    , "Success"
    , "Warning"
    , "Danger"
    ]


toIsModifier : String -> Attribute msg
toIsModifier str =
    class <| "is-" ++ String.toLower str


basicSizes : List String
basicSizes =
    [ "Small"
    , "Normal"
    , "Medium"
    , "Large"
    ]
