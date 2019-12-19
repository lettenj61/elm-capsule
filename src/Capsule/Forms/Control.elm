module Capsule.Forms.Control exposing
    ( Builder
    , build
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


type Builder msg
    = Builder (ControlDetails msg)


defaultControlDetails : ControlDetails msg
defaultControlDetails =
    { attributes = []
    , input = Html.text ""
    , iconLeft = Nothing
    , iconRight = Nothing
    }


fromAttributes : List (Attribute msg) -> Builder msg
fromAttributes attributes =
    Builder { defaultControlDetails | attributes = attributes }


{-| Finalize the builder and produce control node.

    import Capsule.Element exposing (tags, tag)
    import Capsule.Forms.Contol as Builder
    import Capsule.Modifiers exposing (color)
    import Capsule.Style exposing (hasAddons)
    import Capsule.Types.Color exposing (dark, primary)
    import Html exposing (text)

    badge : String -> String -> Html msg
    badge left right =
        Builder.fromAttribute []
            |> Builder.setInput
                (tags [ hasAddons ]
                    [ tag [ color dark ] [ text left ]
                    , tag [ color primary ] [ text right ]
                    ]
                )
            |> Builder build
-}
build : Builder msg -> Html msg
build (Builder details) =
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


modify : (ControlDetails msg -> ControlDetails msg) -> Builder msg -> Builder msg
modify changeDetails (Builder details) =
    Builder (changeDetails details)


setIconLeft : List (Attribute msg) -> String -> Builder msg -> Builder msg
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


setIconRight : List (Attribute msg) -> String -> Builder msg -> Builder msg
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


setInput : Html msg -> Builder msg -> Builder msg
setInput element =
    modify (\details -> { details | input = element })
