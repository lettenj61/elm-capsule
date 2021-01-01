module Capsule.Layout.Grid exposing
    ( Breakpoint
    , ColumnOption
    , mobile
    , tablet
    , desktop
    , widescreen
    , fullHd
    , row
    , column
    , defineColumn
    , width
    , widthAt
    , offset
    , offsetAt
    )

import Capsule.Internal exposing (Tag, defaultDiv, mixin)
import Html exposing (Attribute)
import Html.Attributes exposing (class)



-- BREAKPOINTS


type Breakpoint
    = Mobile
    | Tablet
    | Desktop
    | Widescreen
    | FullHd


mobile : Breakpoint
mobile =
    Mobile


tablet : Breakpoint
tablet =
    Tablet


desktop : Breakpoint
desktop =
    Desktop


widescreen : Breakpoint
widescreen =
    Widescreen


fullHd : Breakpoint
fullHd =
    FullHd


breakpointToName : Breakpoint -> String
breakpointToName bp =
    case bp of
        Mobile ->
            "mobile"

        Tablet ->
            "tablet"

        Desktop ->
            "desktop"

        Widescreen ->
            "widescreen"

        FullHd ->
            "fullhd"



-- COLUMN OPTION


type ColumnOption
    = ColumnWidth Int
    | ColumnWidthAt Int Breakpoint
    | ColumnOffset Int
    | ColumnOffsetAt Int Breakpoint


width : Int -> ColumnOption
width =
    ColumnWidth


widthAt : Int -> Breakpoint -> ColumnOption
widthAt =
    ColumnWidthAt


offset : Int -> ColumnOption
offset =
    ColumnOffset


offsetAt : Int -> Breakpoint -> ColumnOption
offsetAt =
    ColumnOffsetAt


{-| Create row node for Bulma grid system.

    import Capsule.Layout.Grid exposing (..)
    import Capsule.Widgets as UI
    import Html exposing (text)
    import Html.Attributes exposing (class)

    myMessage whatsup =
        UI.notification
            [ class "is-primary" ]
            [ text whatsup ]

    threeColumns =
        row
            []
            [ column [] [ myMessage "First" ]
            , column [] [ myMessage "Second" ]
            , column [] [ myMessage "Third" ]
            ]
-}
row : Tag msg
row =
    defaultDiv "columns"


column : Tag msg
column =
    defaultDiv "column"


{-| Create column node with customizations.

    import Capsule.Layout.Grid exposing (..)

    myColumn =
        defineColumn
            [] -- Custom attributes for wrapper `div` node
            [ width 4
            , widthAt 2 mobile
            , offset 2
            , offsetAt 1 mobile
            ]

    -- <div class="column is-4 is-2-mobile is-offset-2 is-offset-1-mobile" />
-}
defineColumn : List (Attribute msg) -> List ColumnOption -> Tag msg
defineColumn extras options =
    let
        columnClasses =
            List.map
                (\opt ->
                    class (toClassName opt)
                )
                options
    in
    mixin (extras ++ columnClasses) Html.div


toClassName : ColumnOption -> String
toClassName option =
    case option of
        ColumnWidth width_ ->
            "is-" ++ String.fromInt width_

        ColumnWidthAt width_ bp ->
            "is-" ++ String.fromInt width_ ++ "-" ++ breakpointToName bp

        ColumnOffset offset_ ->
            "is-offset-" ++ String.fromInt offset_

        ColumnOffsetAt offset_ bp ->
            "is-offset-" ++ String.fromInt offset_ ++ "-" ++ breakpointToName bp