module Capsule.Forms.Control exposing
    ( Control
    , toHtml
    , fromAttributes
    , setIconLeft
    , setIconRight
    , setInput
    )

import Capsule.Element as El
import Capsule.Forms as Forms
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- CONTROL BUILDER


type alias ControlDetails msg =
    { attributes : List (Attribute msg)
    , input : Html msg
    , iconLeft : Maybe (Html msg)
    , iconRight : Maybe (Html msg)
    }


type Control msg
    = Control (ControlDetails msg)


defaultControl : ControlDetails msg
defaultControl =
    { attributes = []
    , input = Html.text ""
    , iconLeft = Nothing
    , iconRight = Nothing
    }


fromAttributes : List (Attribute msg) -> Control msg
fromAttributes attributes =
    Control { defaultControl | attributes = attributes }


{-| Finalize the builder and produce control node.

    import Capsule.Element exposing (tags, tag)
    import Capsule.Forms.Contol as Control
    import Capsule.Modifiers exposing (color)
    import Capsule.Style exposing (hasAddons)
    import Capsule.Types.Color exposing (dark, primary)
    import Html exposing (text)

    badge : String -> String -> Html msg
    badge left right =
        Control.fromAttributes []
            |> Control.setInput
                (tags [ hasAddons ]
                    [ tag [ color dark ] [ text left ]
                    , tag [ color primary ] [ text right ]
                    ]
                )
            |> Control.toHtml
-}
toHtml : Control msg -> Html msg
toHtml (Control details) =
    let
        forceElement maybeElement =
            maybeElement
                |> Maybe.map List.singleton
                |> Maybe.withDefault []
    in
    Forms.control
        details.attributes
        (List.concat
            [ [ details.input ]
            , forceElement details.iconLeft
            , forceElement details.iconRight
            ]
        )


modify : (ControlDetails msg -> ControlDetails msg) -> Control msg -> Control msg
modify change (Control details) =
    Control (change details)


setIconLeft : List (Attribute msg) -> String -> Control msg -> Control msg
setIconLeft attributes iconName =
    modify
        (\details ->
            { details
                | attributes = class "has-icons-left" :: details.attributes
                , iconLeft =
                    Just <|
                        El.icon
                        (class "is-left" :: attributes)
                        iconName
            }
        )


setIconRight : List (Attribute msg) -> String -> Control msg -> Control msg
setIconRight attributes iconName =
    modify
        (\details ->
            { details
                | attributes = class "has-icons-right" :: details.attributes
                , iconRight =
                    Just <|
                        El.icon
                        (class "is-right" :: attributes)
                        iconName
            }
        )


setInput : Html msg -> Control msg -> Control msg
setInput element =
    modify (\details -> { details | input = element })
