module Capsule.Components.Breadcrumb exposing
    ( arrowSeparator
    , breadcrumb
    , bulletSeparator
    , dotSeparator
    , succeedsSeparator
    )

import Capsule.Builder exposing (Builder)
import Html exposing (Attribute)
import Html.Attributes exposing (class)



-- BREADCRUMB


{-| Create breadcrumb navigation.

Note that inner `ul` element is automatically added.

    import Capsule.Components.Breadcrumb exposing (breadcrumb)
    import Html exposing (..)

    pathNavigation : Html msg
    pathNavigation =
        breadcrumb []
            [ li [] [ a [ href "/first-step" ] [ text "First" ] ]
            , li [] [ a [ href "/javascript" ] [ text "JavaScript" ] ]
            ]

-}
breadcrumb : Builder msg
breadcrumb attributes children =
    Html.nav
        (class "breadcrumb" :: attributes)
        [ Html.ul
            []
            children
        ]


{-| Change separator to arrows.
-}
arrowSeparator : Attribute msg
arrowSeparator =
    class "has-arrow-separator"


{-| Change separator to bullets.
-}
bulletSeparator : Attribute msg
bulletSeparator =
    class "has-bullet-separator"


{-| Change separator to dots.
-}
dotSeparator : Attribute msg
dotSeparator =
    class "has-dot-separator"


{-| Change separator to succeeds.
-}
succeedsSeparator : Attribute msg
succeedsSeparator =
    class "has-succeeds-separator"
