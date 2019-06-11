module Bulma.Internal exposing (Attrs, Builder, Children, Modifier, Wrapper, withClass, wrapHtml)

import Html as H exposing (Attribute, Html)
import Html.Attributes as A


type alias Modifier msg =
    Attribute msg


type alias Attrs a =
    List (Attribute a)


type alias Children a =
    List (Html a)


type alias Builder a =
    Attrs a -> Children a -> Html a


type alias Wrapper msg content =
    Builder msg -> Attrs msg -> content -> Html msg



-- PRIVATE


withClass : String -> (content -> Children msg) -> Wrapper msg content
withClass className liftHtml =
    \builder ->
        \attrs ->
            \value ->
                let
                    newChildren =
                        liftHtml value
                in
                builder
                    ([ A.class className ] ++ attrs)
                    newChildren


wrapHtml : String -> Wrapper msg (Children msg)
wrapHtml className =
    withClass className identity
