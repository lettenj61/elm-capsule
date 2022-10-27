module Bulma.Complex exposing (..)

import Bulma.Internal exposing (styled_)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (attribute, class)


navbar : List (Attribute msg) -> List (Html msg) -> Html msg
navbar attributes children =
    let
        baseAttributes =
            [ class "navbar"
            , attribute "role" "navigation"
            , attribute "aria-label" "navigation"
            ]
    in
    Html.nav
        (baseAttributes ++ attributes)
        children


type alias NavbarProps msg =
    { brand : Maybe (Html msg)
    , menuStart : List (Html msg)
    , menuEnd : List (Html msg)
    }


defaultNavbar : NavbarProps msg
defaultNavbar =
    { brand = Nothing
    , menuStart = []
    , menuEnd = []
    }


navbarWithMenu : List (Attribute msg) -> NavbarProps msg -> Html msg
navbarWithMenu attributes props =
    navbar attributes
        [ case props.brand of
            Just brandItem ->
                Html.div
                    [ class "navbar-brand" ]
                    [ brandItem ]

            Nothing ->
                Html.text ""
        , Html.div
            [ class "navbar-menu is-active" ]
            [ case props.menuStart of
                [] ->
                    Html.text ""

                menuStart ->
                    Html.div
                        [ class "navbar-start" ]
                        menuStart
            , case props.menuEnd of
                [] ->
                    Html.text ""

                menuEnd ->
                    Html.div
                        [ class "navbar-end" ]
                        menuEnd
            ]
        ]


setBrand : Html msg -> NavbarProps msg -> NavbarProps msg
setBrand brand props =
    { props
        | brand = Just brand
    }


setMenuStart : List (Html msg) -> NavbarProps msg -> NavbarProps msg
setMenuStart menuStart props =
    { props
        | menuStart = menuStart
    }


setMenuEnd : List (Html msg) -> NavbarProps msg -> NavbarProps msg
setMenuEnd menuEnd props =
    { props
        | menuEnd = menuEnd
    }


navbarItem :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
navbarItem h =
    styled_ h "navbar-item"


navbarDivider : Html msg
navbarDivider =
    Html.hr [ class "navbar-divider" ] []


menu : List (Attribute msg) -> List (Html msg) -> Html msg
menu =
    styled_ Html.aside "menu"


menuLabel : List (Attribute msg) -> List (Html msg) -> Html msg
menuLabel =
    styled_ Html.p "menu-label"


menuList : List (Attribute msg) -> List (Html msg) -> Html msg
menuList =
    styled_ Html.ul "menu-list"
