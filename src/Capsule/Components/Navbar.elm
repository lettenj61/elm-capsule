module Capsule.Components.Navbar exposing
    ( defaultNavbarMenu
    , navbar
    , navbarBrand
    , navbarBurger
    , navbarDropdown
    , navbarItem
    , navbarItemAnchor
    , navbarLink
    , navbarMenu
    , toNavbarItem
    )

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- NAVBAR


navbar : Builder msg
navbar =
    Html.nav |> withMixins [ class "navbar" ]


navbarBurger : List (Attribute msg) -> Html msg
navbarBurger attributes =
    Html.a (class "navbar-burger" :: attributes) <|
        List.repeat 3 (Html.span [] [])


navbarBrand : Builder msg
navbarBrand =
    Html.div |> withMixins [ class "navbar-brand" ]


navbarDropdown : Builder msg
navbarDropdown =
    Html.div |> withMixins [ class "navbar-dropdown" ]


navbarLink : Builder msg
navbarLink =
    Html.a |> withMixins [ class "navbar-link" ]


navbarItem : Builder msg
navbarItem =
    toNavbarItem Html.div


navbarItemAnchor : Builder msg
navbarItemAnchor =
    toNavbarItem Html.a


toNavbarItem : Builder msg -> Builder msg
toNavbarItem =
    withMixins [ class "navbar-item" ]



-- NAVBAR MENU


type alias NavbarMenuProps msg =
    { start : List (Html msg)
    , end : List (Html msg)
    }


defaultNavbarMenu : NavbarMenuProps msg
defaultNavbarMenu =
    { start = [], end = [] }


navbarMenu : List (Attribute msg) -> NavbarMenuProps msg -> Html msg
navbarMenu attributes props =
    Html.div (class "navbar-menu" :: attributes)
        [ Html.div [ class "navbar-start" ] props.start
        , Html.div [ class "navbar-end" ] props.end
        ]
