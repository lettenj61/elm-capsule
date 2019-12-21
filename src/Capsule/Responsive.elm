module Capsule.Responsive exposing
    ( columnSet
    , columnWidth
    , size
    )

import Capsule.Columns exposing (ColumnWidth, columnWidthToString)
import Capsule.Html.Modifier as Modifier exposing (Modifier, toClass, toClassList)
import Capsule.Types.Breakpoint as Breakpoint exposing (Breakpoint)
import Capsule.Types.Size as Size exposing (Size)
import Html exposing (Attribute)



-- AT BREAKPOINT


atBreakpoint : Breakpoint -> Modifier -> Attribute msg
atBreakpoint breakpoint =
    toClass << atBreakpointToken breakpoint


atBreakpointToken : Breakpoint -> Modifier -> Modifier
atBreakpointToken break modifier =
    let
        suffix =
            "-" ++ Breakpoint.toString break
    in
    Modifier.addSuffix suffix modifier



-- COLUMN WIDTH


columnWidth : ColumnWidth -> Breakpoint -> Attribute msg
columnWidth width break =
    columnWidthToString width
        |> Modifier.fromString
        |> atBreakpoint break


columnSet : List ( ColumnWidth, Breakpoint ) -> Attribute msg
columnSet settings =
    settings
        |> List.map
            (\( width, break ) ->
                atBreakpointToken
                    break
                    (Modifier.fromString <| columnWidthToString <| width)
            )
        |> toClassList



-- SIZE


size : Size -> Breakpoint -> Attribute msg
size val break =
    Size.toString val
        |> Modifier.fromString
        |> atBreakpoint break
