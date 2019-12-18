module Capsule.Html.Internal exposing
    ( Modifier
    , addPrefix
    , addSuffix
    , fromString
    , toClass
    , toClassList
    )

import Html exposing (Attribute)
import Html.Attributes as Attributes


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


toClassList : List Modifier -> List (Attribute msg)
toClassList =
    List.map toClass
