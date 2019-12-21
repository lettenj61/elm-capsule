module Capsule.Html.Modifier exposing
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


toClassList : List Modifier -> Attribute msg
toClassList tokens =
    tokens
        |> List.map (\tok -> ( toString tok, True ))
        |> Attributes.classList


toString : Modifier -> String
toString (Modifier token) =
    token