module Main exposing (Model, init, main)

import Browser
import Bulma as B
import Bulma.Classes as BC
import Bulma.Navbar as Navbar exposing (navbar, navbarItem, navbarOptions)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- INIT


type alias Model =
    ()


init : Model
init =
    ()



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update _ model =
    model



-- VIEW


view : Model -> Html msg
view model =
    div
        []
        [ viewNavbar
        , viewHero
        , B.section
            [ id "main" ]
            [ B.container [] []
            ]
        ]


viewHero : Html msg
viewHero =
    B.hero
        [ BC.primary ]
        [ B.title h1 [] "Hello!"
        , B.subtitle span [] "Bulma <3 Elm"
        ]


viewNavbar : Html msg
viewNavbar =
    let
        viewNavbarMenu =
            div
                [ navbarItem, class "has-dropdown is-hoverable" ]
                [ a [ href "#", class "navbar-link" ] [ text "Samples" ]
                , div
                    [ class "navbar-dropdown" ]
                    [ a [ href "#", navbarItem ] [ text "Link A" ]
                    , a [ href "#", navbarItem ] [ text "Link B" ]
                    ]
                ]

        options =
            { navbarOptions
                | brand = a [ navbarItem ] [ text "EZ" ]
                , menuEnd = [ viewNavbarMenu ]
            }
    in
    navbar [ BC.dark ] options
