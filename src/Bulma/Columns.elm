module Bulma.Columns exposing (columns, row, column)

{-| Module for Bulma CSS columns.


# Define layout

@docs columns, row, column

-}

import Bulma.Internal exposing (styled_)
import Html exposing (Attribute, Html)


{-| Define a set of flexible columns.
-}
columns : List (Attribute msg) -> List (Html msg) -> Html msg
columns =
    styled_ Html.div "columns"


{-| Alias for `columns`.
-}
row : List (Attribute msg) -> List (Html msg) -> Html msg
row =
    columns


{-| Define a column of a grid.
-}
column : List (Attribute msg) -> List (Html msg) -> Html msg
column =
    styled_ Html.div "column"
