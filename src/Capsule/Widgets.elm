module Capsule.Widgets exposing (..)

import Capsule.Internal exposing (Tag, defaultDiv, mixin)
import Html exposing (Attribute, Html)
import Html.Attributes as Attrs exposing (class)



-- BLOCK


block : Tag msg
block =
    defaultDiv "block"



-- BOX


box : Tag msg
box =
    defaultDiv "box"



-- CONTENT


content : Tag msg
content =
    defaultDiv "content"



-- BUTTONS


buttons : Tag msg
buttons =
    defaultDiv "buttons"


button : Tag msg
button =
    Html.button |> mixin [ class "button" ]


buttonA : Tag msg
buttonA =
    Html.a |> mixin [ class "button" ]


buttonInput : Tag msg
buttonInput =
    Html.input |> mixin [ class "button" ]



-- NOTIFICATION


notification : Tag msg
notification =
    defaultDiv "notification"



-- TABLE


table : Tag msg
table =
    Html.table |> mixin [ class "table" ]



-- TAGS


tags : Tag msg
tags =
    defaultDiv "tags"


tag : Tag msg
tag =
    Html.span |> mixin [ class "tag" ]


tagA : Tag msg
tagA =
    Html.a |> mixin [ class "tag" ]



-- DELETE


delete : Tag msg
delete =
    Html.button |> mixin [ class "delete" ]


deleteA : Tag msg
deleteA =
    Html.a |> mixin [ class "delete" ]
