module Capsule.Size exposing
    ( Size
    , small
    , medium
    , large
    , toString
    )



-- SIZES


type Size =
    Size String


small : Size
small =
    Size "small"


medium : Size
medium =
    Size "medium"


large : Size
large =
    Size "large"


toString : Size -> String
toString (Size name) =
    name