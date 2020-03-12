module Capsule.Components.Menu exposing
    ( menu
    , menuLabel
    , menuList
    )

import Capsule.Builder exposing (Builder, withMixins)
import Html
import Html.Attributes exposing (class)



-- MENU


menu : Builder msg
menu =
    toMenu Html.aside


toMenu : Builder msg -> Builder msg
toMenu =
    withMixins [ class "menu" ]


menuLabel : Builder msg
menuLabel =
    Html.p |> withMixins [ class "menu-label" ]


menuList : Builder msg
menuList =
    Html.ul |> withMixins [ class "menu-list" ]
