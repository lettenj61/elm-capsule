module Showcase.Scheme exposing (Scheme(..), toColor)

import Capsule.Types.Color as Color exposing (Color)


type Scheme
    = Primary
    | Info
    | Warning
    | Danger
    | Success
    | Dark
    | White
    | Black
    | Light


toColor : Scheme -> Color
toColor scheme =
    case scheme of
        Primary ->
            Color.primary

        Info ->
            Color.info

        Warning ->
            Color.warning

        Danger ->
            Color.danger

        Success ->
            Color.success

        Dark ->
            Color.dark

        White ->
            Color.white

        Black ->
            Color.black

        Light ->
            Color.light
