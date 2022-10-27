module Bulma.Columns exposing (..)


import Bulma.Internal exposing (styled_)
import Html exposing (Attribute, Html)


columns : List (Attribute msg) -> List (Html msg) -> Html msg
columns =
    styled_ Html.div "columns"


{-| Alias for `columns`
-}
row : List (Attribute msg) -> List (Html msg) -> Html msg
row =
    columns


column : List (Attribute msg) -> List (Html msg) -> Html msg
column =
    styled_ Html.div "column"