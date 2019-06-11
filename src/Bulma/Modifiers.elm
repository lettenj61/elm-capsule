module Bulma.Modifiers exposing (info, link, primary)

import Html as H exposing (Attribute, Html)
import Html.Attributes as A exposing (class)



-- HELPERS


type alias Modifier a =
    Attribute a


primary : Modifier msg
primary =
    class "is-primary"


link : Modifier msg
link =
    class "is-link"


info : Modifier msg
info =
    class "is-info"


success : Modifier msg
success =
    class "is-success"


warning : Modifier msg
warning =
    class "is-warning"


danger : Modifier msg
danger =
    class "is-danger"


dark : Modifier msg
dark =
    class "is-dark"


light : Modifier msg
light =
    class "is-light"


black : Modifier msg
black =
    class "is-black"


size : Int -> Modifier msg
size n =
    class <| "is-" ++ String.fromInt n
