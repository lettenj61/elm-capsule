module Capsule.TableStyle exposing
    ( bordered
    , fullwidth
    , hoverable
    , narrow
    , selected
    , striped
    )

import Capsule.Style as Style
import Html exposing (Attribute)
import Html.Attributes exposing (class)


selected : Attribute msg
selected =
    class "is-selected"


bordered : Attribute msg
bordered =
    class "is-bordered"


striped : Attribute msg
striped =
    class "is-striped"


narrow : Attribute msg
narrow =
    Style.narrow


hoverable : Attribute msg
hoverable =
    Style.hoverable


fullwidth : Attribute msg
fullwidth =
    Style.fullwidth
