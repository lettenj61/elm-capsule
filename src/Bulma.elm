module Bulma exposing (column, columns, container, content, hero, section, subtitle, subtitleSpan, title, titleH1)

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



-- LAYOUTS


section : Attrs msg -> Children msg -> Html msg
section attrs children =
    H.section ([ A.class "section" ] ++ attrs) children


container : Attrs msg -> Children msg -> Html msg
container attrs children =
    H.div ([ A.class "container" ] ++ attrs) children


hero : Builder msg
hero =
    wrapHtml "hero" H.div


columns : Builder msg
columns =
    wrapHtml "columns" H.div


column : Builder msg
column =
    wrapHtml "column" H.div



-- ELEMENTS


content : Builder msg
content =
    wrapHtml "content" H.div



-- TYPOGRAPHY


title : Wrapper msg String
title =
    withClass "title" (List.singleton << H.text)


titleH1 : Attrs msg -> String -> Html msg
titleH1 =
    title H.h1


subtitle : Wrapper msg String
subtitle =
    withClass "subtitle" (List.singleton << H.text)


subtitleSpan : Attrs msg -> String -> Html msg
subtitleSpan =
    subtitle H.span



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
