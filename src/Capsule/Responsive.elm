module Capsule.Responsive exposing
    ( columnWidth
    , size
    )

import Capsule.Types.Breakpoint as Breakpoint exposing (Breakpoint)
import Capsule.Types.Size as Size exposing (Size)
import Capsule.Columns exposing (ColumnWidth, columnWidthToString)
import Capsule.Html.Modifier as Modifier exposing (Modifier, toClass)
import Html exposing (Attribute)



-- AT BREAKPOINT


atBreakpoint : Breakpoint -> Modifier -> Attribute msg
atBreakpoint break modifier =
    let
        suffix =
            "-" ++ Breakpoint.toString break
    in
    toClass <| Modifier.addSuffix suffix modifier



-- COLUMN WIDTH


columnWidth : ColumnWidth -> Breakpoint -> Attribute msg
columnWidth width break =
    columnWidthToString width
        |> Modifier.fromString
        |> atBreakpoint break



-- SIZE


size : Size -> Breakpoint -> Attribute msg
size val break =
    Size.toString val
        |> Modifier.fromString
        |> atBreakpoint break

