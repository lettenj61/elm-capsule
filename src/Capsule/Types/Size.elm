module Capsule.Types.Size exposing
    ( Size
    , fromInt
    , large
    , medium
    , small
    , toString
    )

-- SIZES


type Size
    = Size String


small : Size
small =
    Size "small"


medium : Size
medium =
    Size "medium"


large : Size
large =
    Size "large"


fromInt : Int -> Size
fromInt =
    Size << String.fromInt


toString : Size -> String
toString (Size name) =
    name
