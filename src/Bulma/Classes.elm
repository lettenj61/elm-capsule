module Bulma.Classes exposing (Breakpoint(..), black, danger, dark, info, light, link, primary, size, success, textBlack, textDanger, textDark, textInfo, textLight, textLink, textPrimary, textSuccess, textWarning, textWhite, warning)

import Html as H exposing (Attribute, Html)
import Html.Attributes as A exposing (class)


type Breakpoint
    = Touch
    | Tablet
    | Desktop
    | Widescreen
    | FullHD


showBreakpoint : Breakpoint -> String
showBreakpoint bp =
    case bp of
        Touch ->
            "touch"

        Tablet ->
            "tablet"

        Desktop ->
            "desktop"

        Widescreen ->
            "widescreen"

        FullHD ->
            "fullhd"



-- HELPERS


primary : Attribute msg
primary =
    class "is-primary"


link : Attribute msg
link =
    class "is-link"


info : Attribute msg
info =
    class "is-info"


success : Attribute msg
success =
    class "is-success"


warning : Attribute msg
warning =
    class "is-warning"


danger : Attribute msg
danger =
    class "is-danger"


dark : Attribute msg
dark =
    class "is-dark"


light : Attribute msg
light =
    class "is-light"


black : Attribute msg
black =
    class "is-black"


size : Int -> Attribute msg
size n =
    class <| "is-" ++ String.fromInt n



-- TYPOGRAPHY


textWhite : Attribute msg
textWhite =
    textMod "white"


textBlack : Attribute msg
textBlack =
    textMod "black"


textLight : Attribute msg
textLight =
    textMod "light"


textDark : Attribute msg
textDark =
    textMod "dark"


textPrimary : Attribute msg
textPrimary =
    textMod "primary"


textInfo : Attribute msg
textInfo =
    textMod "info"


textLink : Attribute msg
textLink =
    textMod "link"


textSuccess : Attribute msg
textSuccess =
    textMod "success"


textWarning : Attribute msg
textWarning =
    textMod "warning"


textDanger : Attribute msg
textDanger =
    textMod "danger"



-- PRIVATE


responsive_ : String -> Breakpoint -> Attribute msg
responsive_ className bp =
    let
        prefix =
            "is-" ++ className ++ "-"
    in
    showBreakpoint bp
        |> String.append prefix
        |> class


textMod : String -> Attribute msg
textMod suffix =
    class <| "has-text-" ++ suffix
