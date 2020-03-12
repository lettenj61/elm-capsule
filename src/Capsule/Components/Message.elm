module Capsule.Components.Message exposing
    ( message
    , messageBody
    , messageHeader
    )

import Capsule.Builder exposing (Builder, withMixins)
import Html
import Html.Attributes exposing (class)



-- MESSAGE


message : Builder msg
message =
    Html.article |> withMixins [ class "message" ]


messageHeader : Builder msg
messageHeader =
    Html.div |> withMixins [ class "message-header" ]


messageBody : Builder msg
messageBody =
    Html.div |> withMixins [ class "message-body" ]
