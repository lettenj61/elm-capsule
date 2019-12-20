module KitchenSink exposing (main)

import Browser
import Capsule.Components.Navbar as Navbar exposing (defaultNavbarMenu)
import Capsule.Columns as Column
import Capsule.Element as El
import Capsule.Layout as Layout
import Capsule.Modifiers exposing (color)
import Capsule.Style as Style
import Capsule.Types.Color as Color
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


init : Model
init =
    Nothing



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


type alias Detail msg =
    { title : String
    , subtitle : Maybe String
    , content : List (Html msg)
    }


view : Model -> Html Msg
view _ =
    Html.div []
        [ viewNavbar
        ]


viewNavbar : Html msg
viewNavbar =
    Navbar.navbar [ color Color.dark ]
        [ Navbar.navbarBrand []
            [ Navbar.navbarItem
                []
                [ Html.span [] [ Html.text "Elm Capsule" ] ]
            , Navbar.navbarBurger []
            ]
        , Navbar.navbarMenu [ Style.active ]
            { defaultNavbarMenu
                | start =
                    [ Navbar.navbarItemAnchor [] [ Html.text "Menu" ]
                    ]
            }
        ]


viewFromDetail : Detail msg -> List (Html msg)
viewFromDetail { title, subtitle, content } =
    [ Layout.hero [] <|
        [ El.title [] [ Html.text title ]
        , subtitle
            |> Maybe.map (\val -> El.subtitle [] [ Html.text val ])
            |> Maybe.withDefault (Html.text "")
        ]
        ++ content
    ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
