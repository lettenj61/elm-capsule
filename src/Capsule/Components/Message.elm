module Capsule.Components.Message exposing
    ( message
    , messageBody
    , messageHeader
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html
import Html.Attributes exposing (class)



-- MESSAGE


message : Tagger msg
message =
    Html.article |> withMixins [ class "message" ]


messageHeader : Tagger msg
messageHeader =
    Html.div |> withMixins [ class "message-header" ]


messageBody : Tagger msg
messageBody =
    Html.div |> withMixins [ class "message-body" ]
