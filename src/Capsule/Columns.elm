module Capsule.Columns exposing
    ( ColumnWidth
    , column
    , columnWidth
    , columnWidthToString
    , columns
    , gapless
    , half
    , intToColumnWidth
    , oneQuarter
    , oneThird
    , threeQuarters
    , twoThirds
    , withOffset
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute)
import Html.Attributes exposing (class)



-- COLUMNS


column : Tagger msg
column =
    Html.div |> withMixins [ class "column" ]


columns : Tagger msg
columns =
    Html.div |> withMixins [ class "columns" ]



-- COLUMN WIDTH


type ColumnWidth
    = ColumnWidth String


columnWidthToString : ColumnWidth -> String
columnWidthToString (ColumnWidth name) =
    name


threeQuarters : ColumnWidth
threeQuarters =
    ColumnWidth "three-quarters"


twoThirds : ColumnWidth
twoThirds =
    ColumnWidth "two-thirds"


half : ColumnWidth
half =
    ColumnWidth "half"


oneQuarter : ColumnWidth
oneQuarter =
    ColumnWidth "one-quarter"


oneThird : ColumnWidth
oneThird =
    ColumnWidth "one-third"


intToColumnWidth : Int -> ColumnWidth
intToColumnWidth =
    ColumnWidth << String.fromInt


columnWidth : ColumnWidth -> Attribute msg
columnWidth width =
    class <| "is-" ++ columnWidthToString width


withOffset : ColumnWidth -> Attribute msg
withOffset width =
    class <| "is-offset-" ++ columnWidthToString width



-- OTHER MODIFIERS


gapless : Attribute msg
gapless =
    class "is-gapless"
