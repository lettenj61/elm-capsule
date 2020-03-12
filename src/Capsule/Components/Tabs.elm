module Capsule.Components.Tabs exposing (tabs)

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (nav)
import Html.Attributes exposing (class)



-- TABS


tabs : Builder msg
tabs =
    nav |> withMixins [ class "tabs" ]
