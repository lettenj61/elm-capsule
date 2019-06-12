module Bulma.Internal exposing (Attrs, Builder, Children, Modifier, Wrapper, liftTree, withClass, wrapHtml)

import Html as H exposing (Attribute, Html)
import Html.Attributes exposing (class)


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
                    ([ class className ] ++ attrs)
                    newChildren


wrapHtml : String -> Wrapper msg (Children msg)
wrapHtml className =
    withClass className identity


liftTree : String -> Builder msg -> Children msg -> Children msg
liftTree className builder children =
    case children of
        [] ->
            []

        subTree ->
            List.singleton <|
                builder [ class className ] subTree
