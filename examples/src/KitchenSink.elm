module KitchenSink exposing (main)

import Browser
import Bulma.Columns as Columns
import Bulma.Complex as Widget
import Bulma.Element as El
import Bulma.Form as Form
import Bulma.Layout as Layout
import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, id)



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



-- UPDATE


type Msg
    = Msg


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewHeader
        , viewMain
            [ viewMedia
            , viewButtons
            , viewSelectVariants
            ]
        ]


viewHeader : Html msg
viewHeader =
    header []
        [ Widget.navbarWithMenu [ class "is-dark has-shadow" ]
            (Widget.defaultNavbar
                |> Widget.setBrand
                    (Widget.navbarItem div
                        [ class "has-text-weight-bold"
                        ]
                        [ text "Logo" ]
                    )
                |> Widget.setMenuStart
                    [ Widget.navbarItem a
                        [ href "#" ]
                        [ text "Home" ]
                    ]
            )
        ]


viewMain : List (Html msg) -> Html msg
viewMain children =
    main_ [ class "mt-4" ]
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
            [ li []
                [ a [] [ text "Media" ] ]
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
            [ Layout.buttons [ class "are-medium" ]
                (basicColors
                    |> List.map
                        (\colorName ->
                            El.button
                                [ toIsModifier colorName ]
                                [ text colorName ]
                        )
                )
            , Layout.buttons [ class "are-medium" ]
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
            , Layout.buttons [ class "are-medium" ]
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
                        [ El.control []
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
