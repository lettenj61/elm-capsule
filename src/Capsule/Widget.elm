module Capsule.Widget exposing
    ( button
    , buttonAnchor
    , buttons
    , content
    , tag
    , tags
    , title
    , section
    , subtitle
    )


import Capsule.Builder as Builder exposing (Builder, Wrapper, withMixins)
import Capsule.Components.Breadcrumb as Breadcrumb
import Capsule.Element as El
import Capsule.Layout as Layout
import Capsule.Modifiers as Mod
import Html exposing (Attribute, Html)


-- WIDGET


type alias Widget a msg =
    List (Attribute msg) -> a -> Html msg


widget : (a -> Html msg) -> Builder msg -> Widget a msg
widget view builder mixins model =
    builder mixins [ view model ]


textWidget : Builder msg -> Widget String msg
textWidget builder =
    widget Html.text builder



-- ELEMENTS


button : Widget String msg
button =
    textWidget El.button


buttonAnchor : Widget String msg
buttonAnchor =
    textWidget El.buttonAnchor


buttons : Builder msg
buttons =
    El.buttons


content : Wrapper msg
content children =
    El.content [] children


title : Widget String msg
title =
    textWidget El.title


subtitle : Widget String msg
subtitle =
    textWidget El.subtitle


tag : Widget String msg
tag =
    textWidget El.tag


tags : Builder msg
tags =
    El.tags



-- LAYOUT


section : Bool -> List (Html msg) -> Html msg
section isFluid body =
    let
        container =
            if isFluid then
                Layout.container
            else
                Layout.fluidContainer
    in
    Layout.section
        []
        [ container [] body
        ]



-- HELPERS
