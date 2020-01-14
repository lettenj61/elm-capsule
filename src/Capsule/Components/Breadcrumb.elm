module Capsule.Components.Breadcrumb exposing
    ( arrowSeparator
    , breadcrumb
    , bulletSeparator
    , dotSeparator
    , succeedsSeparator
    )

import Capsule.Html exposing (Tagger)
import Html exposing (Attribute)
import Html.Attributes exposing (class)



-- BREADCRUMB


{-| Create breadcrumb navigation.

Note that inner `ul` element is automatically added.

    pathNavigation : Html msg
    pathNavigation =
        breadcrumb []
            [ li [] [ a [ href "/first-step" ] [ text "First" ] ]
            , li [] [ a [ href "/javascript" ] [ text "JavaScript" ] ]
            ]

-}
breadcrumb : Tagger msg
breadcrumb attributes children =
    Html.nav
        (class "breadcrumb" :: attributes)
        [ Html.ul
            []
            children
        ]


arrowSeparator : Attribute msg
arrowSeparator =
    class "has-arrow-separator"


bulletSeparator : Attribute msg
bulletSeparator =
    class "has-bullet-separator"


dotSeparator : Attribute msg
dotSeparator =
    class "has-dot-separator"


succeedsSeparator : Attribute msg
succeedsSeparator =
    class "has-succeeds-separator"
