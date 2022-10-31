module Bulma.Form exposing
    ( field, fieldWithAddons, groupedField, label, control
    , ControlWithIconsProps, controlWithIcons, wrapControlWithIcons, setIconLeft, setIconRight
    , input, checkbox
    , textarea
    , SelectProps, select
    )

{-| Bulma form controls.


# General

@docs field, fieldWithAddons, groupedField, label, control
@docs ControlWithIconsProps, controlWithIcons, wrapControlWithIcons, setIconLeft, setIconRight
@docs input, checkbox
@docs textarea
@docs SelectProps, select

-}

import Bulma.Internal exposing (styled_)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)


{-| -}
field : List (Attribute msg) -> List (Html msg) -> Html msg
field =
    styled_ Html.div "field"


{-| -}
groupedField : List (Attribute msg) -> List (Html msg) -> Html msg
groupedField =
    styled_ Html.div "field is-grouped"


{-| -}
fieldWithAddons : List (Attribute msg) -> List (Html msg) -> Html msg
fieldWithAddons =
    styled_ Html.div "field has-addons"


{-| -}
label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    styled_ Html.label "label"


{-| Special wrapper element for form controls.
-}
control : List (Attribute msg) -> List (Html msg) -> Html msg
control =
    styled_ Html.div "control"


{-| -}
type alias ControlWithIconsProps msg =
    { control : Html msg
    , iconLeft : Maybe (Html msg)
    , iconRight : Maybe (Html msg)
    }


{-| -}
controlWithIcons : List (Attribute msg) -> ControlWithIconsProps msg -> Html msg
controlWithIcons attributes props =
    let
        classSuffix =
            case ( props.iconLeft, props.iconRight ) of
                ( Nothing, Nothing ) ->
                    ""

                ( Just _, Just _ ) ->
                    " has-icons-left has-icons-right"

                ( Just _, _ ) ->
                    " has-icons-left"

                ( _, Just _ ) ->
                    " has-icons-right"

        controlClass =
            class ("control" ++ classSuffix)
    in
    Html.div
        (controlClass :: attributes)
        [ props.control
        , Maybe.withDefault (Html.text "") props.iconLeft
        , Maybe.withDefault (Html.text "") props.iconRight
        ]


{-| -}
wrapControlWithIcons : Html msg -> ControlWithIconsProps msg
wrapControlWithIcons control_ =
    { control = control_
    , iconLeft = Nothing
    , iconRight = Nothing
    }


{-| -}
setIconLeft : Html msg -> ControlWithIconsProps msg -> ControlWithIconsProps msg
setIconLeft iconLeft props =
    { props | iconLeft = Just iconLeft }


{-| -}
setIconRight : Html msg -> ControlWithIconsProps msg -> ControlWithIconsProps msg
setIconRight iconRight props =
    { props | iconRight = Just iconRight }


{-| -}
input : List (Attribute msg) -> List (Html msg) -> Html msg
input =
    styled_ Html.input "input"


{-| Properties for typical Bulma `select` element.
-}
type alias SelectProps msg =
    { wrapper : List (Attribute msg)
    , inner : List (Attribute msg)
    , options : List (Html msg)
    }


{-| Render a `select` wrapped inside a `div.select`.

    import Bulma.Form as B
    import Html
    import Html.Attributes as A

    languages : Html msg
    languages =
        B.select
            { wrapper = [ A.class "is-large" ]
            , inner = []
            , options =
                [ Html.option [] [ Html.text "Japanese, JP" ]
                , Html.option [] [ Html.text "English, US" ]
                , Html.option [] [ Html.text "Chinese, ZH" ]
                ]
            }

    -- <div class="select is-large">
    --     <select>
    --         <option>Japanese, JP</option>
    --         <option>English, US</option>
    --         <option>Chinese, ZH</option>
    --     </select>
    -- </div>

-}
select : SelectProps msg -> Html msg
select props =
    styled_ Html.div
        "select"
        props.wrapper
        [ Html.select
            props.inner
            props.options
        ]


{-| -}
textarea : List (Attribute msg) -> List (Html msg) -> Html msg
textarea =
    styled_ Html.textarea "textarea"


{-| -}
checkbox : List (Html msg) -> Html msg
checkbox =
    Html.label
        [ class "checkbox" ]
