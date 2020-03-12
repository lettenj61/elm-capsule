module Capsule.Modifiers exposing
    ( active
    , backgroundColor
    , bold
    , bordered
    , boxed
    , centered
    , clearfix
    , clipped
    , color
    , expanded
    , focused
    , fullheightWithNavbar
    , fullwidth
    , groupedCenter
    , groupedRight
    , hasAddons
    , hasAddonsCenter
    , hasAddonsLeft
    , hasAddonsRight
    , hoverable
    , hovered
    , inverted
    , invisible
    , light
    , loading
    , marginless
    , narrow
    , outlined
    , overlay
    , paddingless
    , pulledLeft
    , pulledRight
    , radiusless
    , relative
    , right
    , rounded
    , selected
    , shadowless
    , size
    , srOnly
    , static
    , striped
    , textColor
    , toggle
    , toggleRounded
    , unselectable
    , up
    , vertical
    )

import Capsule.Types.Color as Color exposing (Color)
import Capsule.Types.Size as Size exposing (Size)
import Html exposing (Attribute)
import Html.Attributes exposing (class)



-- COLORS


backgroundColor : Color -> Attribute msg
backgroundColor name =
    class <| "has-background-" ++ Color.toString name


color : Color -> Attribute msg
color name =
    class <| "is-" ++ Color.toString name


textColor : Color -> Attribute msg
textColor name =
    class <| "has-text-" ++ Color.toString name


size : Size -> Attribute msg
size val =
    class <| "is-" ++ Size.toString val



-- COMMON SHAPES


rounded : Attribute msg
rounded =
    class "is-rounded"



-- HERO GRADIANT


bold : Attribute msg
bold =
    class "is-bold"



-- HERO HEIGHT


fullheightWithNavbar : Attribute msg
fullheightWithNavbar =
    class "is-fullheight-with-navbar"



-- DARK AND LIGHT


light : Attribute msg
light =
    class "is-light"



-- WIDTH CONTROL


narrow : Attribute msg
narrow =
    class "is-narrow"


fullwidth : Attribute msg
fullwidth =
    class "is-fullwidth"



-- POSITION AND DIRECTION


centered : Attribute msg
centered =
    class "is-centered"


up : Attribute msg
up =
    class "is-up"


right : Attribute msg
right =
    class "is-right"



-- STATE MODIFIERS


focused : Attribute msg
focused =
    class "is-focused"


hoverable : Attribute msg
hoverable =
    class "is-hoverable"


static : Attribute msg
static =
    class "is-static"


active : Attribute msg
active =
    class "is-active"


hovered : Attribute msg
hovered =
    class "is-hovered"


loading : Attribute msg
loading =
    class "is-loading"


expanded : Attribute msg
expanded =
    class "is-expanded"



-- HAS ADDONS


hasAddons : Attribute msg
hasAddons =
    class "has-addons"


hasAddonsRight : Attribute msg
hasAddonsRight =
    class "has-addons has-addons-right"


hasAddonsLeft : Attribute msg
hasAddonsLeft =
    class "has-addons has-addons-left"


hasAddonsCenter : Attribute msg
hasAddonsCenter =
    class "has-addons has-addons-centered"



-- GROUPED IN POSITION


groupedCenter : Attribute msg
groupedCenter =
    class "is-grouped-centered"


groupedRight : Attribute msg
groupedRight =
    class "is-grouped-right"



-- FLOAT MODIFIERS


clearfix : Attribute msg
clearfix =
    class "is-clearfix"


pulledLeft : Attribute msg
pulledLeft =
    class "is-pulled-left"


pulledRight : Attribute msg
pulledRight =
    class "is-pulled-right"



-- SPACING MODIFIERS


marginless : Attribute msg
marginless =
    class "is-marginless"


paddingless : Attribute msg
paddingless =
    class "is-paddingless"



-- OTHER MODIFIERS


overlay : Attribute msg
overlay =
    class "is-overlay"


clipped : Attribute msg
clipped =
    class "is-clipped"


radiusless : Attribute msg
radiusless =
    class "is-radiusless"


shadowless : Attribute msg
shadowless =
    class "is-shadowless"


unselectable : Attribute msg
unselectable =
    class "is-unselectable"


invisible : Attribute msg
invisible =
    class "is-invisible"


srOnly : Attribute msg
srOnly =
    class "is-sr-only"


relative : Attribute msg
relative =
    class "is-relative"



-- TILE DIRECTION


vertical : Attribute msg
vertical =
    class "is-vertical"



-- TAB SHAPE


boxed : Attribute msg
boxed =
    class "is-boxed"


toggle : Attribute msg
toggle =
    class "is-toggle"


toggleRounded : Attribute msg
toggleRounded =
    class "is-toggle is-toggle-rounded"



-- TABLE STYLES


selected : Attribute msg
selected =
    class "is-selected"


bordered : Attribute msg
bordered =
    class "is-bordered"


striped : Attribute msg
striped =
    class "is-striped"



-- BUTTON VARIANT


outlined : Attribute msg
outlined =
    class "is-outlined"


inverted : Attribute msg
inverted =
    class "is-inverted"