module Bulma.Navbar exposing (Navbar, divider, navbar, navbarItem, navbarOptions)

import Bulma.Internal exposing (Attrs, Builder, Children, Wrapper, withClass, wrapHtml)
import Html as H exposing (Attribute, Html)
import Html.Attributes as A



-- NAVBAR


type alias Navbar msg =
    { brand : Html msg
    , burger : Maybe (Html msg)
    , menuStart : Children msg
    , menuEnd : Children msg
    }


navbarOptions : Navbar msg
navbarOptions =
    { brand = H.text ""
    , burger = Nothing
    , menuStart = []
    , menuEnd = []
    }


navbar : Navbar msg -> Attrs msg -> Html msg
navbar options =
    let
        { brand, menuStart, menuEnd } =
            options
    in
    \attrs ->
        H.nav
            ([ A.class "navbar" ] ++ attrs)
            [ H.div [ A.class "navbar-brand" ] [ brand ]
            , H.div
                [ A.class "navbar-menu" ]
                [ H.div [ A.class "navbar-start" ] menuStart
                , H.div [ A.class "navbar-end" ] menuEnd
                ]
            ]


navbarItem : Attribute msg
navbarItem =
    A.class "navbar-item"


divider : Html msg
divider =
    H.hr [ A.class "navbar-divider" ] []
