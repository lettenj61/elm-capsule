module Capsule.Components.Tabs exposing (tabs)

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (nav)
import Html.Attributes exposing (class)



-- TABS


tabs : Tagger msg
tabs =
    nav |> withMixins [ class "tabs" ]
