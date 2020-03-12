module Capsule.Builder exposing
    ( Builder
    , Wrapper
    , decorate
    , withMixins
    , Modifier
    , addPrefix
    , addSuffix
    , fromString
    , toClass
    , toClassList
    )

import Html exposing (Attribute, Html)
import Html.Attributes as Attributes



-- BUILDER


type alias Builder msg =
    List (Attribute msg) -> List (Html msg) -> Html msg


type alias Wrapper msg =
    List (Html msg) -> Html msg


-- DECORATIONS


decorate : Builder msg -> List (Attribute msg) -> Builder msg
decorate builder mixins =
    withMixins mixins builder


withMixins : List (Attribute msg) -> Builder msg -> Builder msg
withMixins mixins builder =
    \attributes ->
        \children ->
            builder (mixins ++ attributes) children



-- MODIFIERS


type Modifier
    = Modifier String


fromString : String -> Modifier
fromString =
    Modifier


addPrefix : String -> Modifier -> Modifier
addPrefix prefix (Modifier token) =
    fromString (prefix ++ token)


addSuffix : String -> Modifier -> Modifier
addSuffix suffix (Modifier token) =
    fromString (token ++ suffix)


toClass : Modifier -> Attribute msg
toClass (Modifier token) =
    Attributes.class token


toClassList : List Modifier -> Attribute msg
toClassList tokens =
    tokens
        |> List.map (\tok -> ( toString tok, True ))
        |> Attributes.classList


toString : Modifier -> String
toString (Modifier token) =
    token
