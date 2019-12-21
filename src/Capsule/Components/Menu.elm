module Capsule.Components.Menu exposing
    ( menu
    , menuLabel
    , menuList
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html
import Html.Attributes exposing (class)



-- MENU


menu : Tagger msg
menu =
    toMenu Html.aside


toMenu : Tagger msg -> Tagger msg
toMenu =
    withMixins [ class "menu" ]


menuLabel : Tagger msg
menuLabel =
    Html.p |> withMixins [ class "menu-label" ]


menuList : Tagger msg
menuList =
    Html.ul |> withMixins [ class "menu-list" ]
