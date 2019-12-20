module Capsule.Components.Dropdown exposing
    ( dropdown
    , dropdownContent
    , dropdownDivider
    , dropdownItem
    , dropdownItemAnchor
    , dropdownMenu
    , dropdownTrigger
    , toDropdownItem
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- DROPDOWN


dropdown : Tagger msg
dropdown =
    Html.div |> withMixins [ class "dropdown" ]


dropdownTrigger : Tagger msg
dropdownTrigger =
    Html.button |> withMixins [ class "dropdown-trigger" ]


dropdownMenu : Tagger msg
dropdownMenu =
    Html.div |> withMixins [ class "dropdown-menu" ]


dropdownDivider : List (Attribute msg) -> Html msg
dropdownDivider attributes =
    Html.hr
        (class "dropdown-divider" :: attributes)
        []


dropdownContent : Tagger msg
dropdownContent =
    Html.div |> withMixins [ class "dropdown-content" ]


dropdownItem : Tagger msg
dropdownItem =
    toDropdownItem Html.div


dropdownItemAnchor : Tagger msg
dropdownItemAnchor =
    toDropdownItem Html.a


toDropdownItem : Tagger msg -> Tagger msg
toDropdownItem =
    withMixins [ class "dropdown-item" ]
