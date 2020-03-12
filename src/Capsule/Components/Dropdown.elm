module Capsule.Components.Dropdown exposing
    ( dropdown
    , dropdownAnchor
    , dropdownContent
    , dropdownDivider
    , dropdownItem
    , dropdownMenu
    , dropdownTrigger
    , toDropdownItem
    , toDropdownTrigger
    )

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- DROPDOWN


dropdown : Builder msg
dropdown =
    Html.div |> withMixins [ class "dropdown" ]


dropdownTrigger : Builder msg
dropdownTrigger attributes children =
    toDropdownTrigger
        Html.button
            (class "button" :: attributes)
            children


toDropdownTrigger : Builder msg -> Builder msg
toDropdownTrigger builder attributes children =
    Html.div
        [ class "dropdown-trigger" ]
        [ builder attributes children
        ]


dropdownMenu : Builder msg
dropdownMenu attributes children =
    Html.div
        [ class "dropdown-menu" ]
        [ dropdownContent attributes children
        ]


dropdownDivider : List (Attribute msg) -> Html msg
dropdownDivider attributes =
    Html.hr
        (class "dropdown-divider" :: attributes)
        []


dropdownContent : Builder msg
dropdownContent =
    Html.div |> withMixins [ class "dropdown-content" ]


dropdownItem : Builder msg
dropdownItem =
    toDropdownItem Html.div


dropdownAnchor : Builder msg
dropdownAnchor =
    toDropdownItem Html.a


toDropdownItem : Builder msg -> Builder msg
toDropdownItem =
    withMixins [ class "dropdown-item" ]
