module Bulma exposing (breadcrumb, column, columns, container, content, hero, section, subtitle, subtitleSpan, title, titleH1)

import Bulma.Internal exposing (Attrs, Builder, Children, Wrapper, withClass, wrapHtml)
import Html as H exposing (Attribute, Html)
import Html.Attributes as A



-- LAYOUTS


section : Attrs msg -> Children msg -> Html msg
section attrs children =
    H.section ([ A.class "section" ] ++ attrs) children


container : Attrs msg -> Children msg -> Html msg
container attrs children =
    H.div ([ A.class "container" ] ++ attrs) children


hero : Builder msg
hero attrs children =
    let
        heroBody =
            wrapHtml "hero-body" H.div

        content_ =
            [ container [] children ]
    in
    H.section
        ([ A.class "hero" ] ++ attrs)
        [ heroBody
            []
            content_
        ]


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


button : Wrapper msg String
button =
    withClass "button" (List.singleton << H.text)



-- COMPONENTS


breadcrumb : Builder msg
breadcrumb =
    wrapHtml "breadcrumb" H.nav



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
