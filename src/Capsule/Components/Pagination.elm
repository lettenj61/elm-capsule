module Capsule.Components.Pagination exposing
    ( pagination
    , paginationEllipsis
    , paginationList
    , paginationNext
    , paginationPrevious
    , toPaginationList
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- PAGINATION


type alias PaginationProps msg =
    { previous : Html msg
    , next : Html msg
    , list : List (Html msg)
    }


pagination : List (Attribute msg) -> PaginationProps msg -> Html msg
pagination attributes props =
    Html.nav (class "pagination" :: attributes) <|
        List.concat
            [ [ props.previous, props.next ]
            , props.list
            ]


paginationPrevious : Tagger msg
paginationPrevious =
    Html.a |> withMixins [ class "pagination-previous" ]


paginationNext : Tagger msg
paginationNext =
    Html.a |> withMixins [ class "pagination-next" ]


toPaginationList : Tagger msg -> Tagger msg
toPaginationList =
    withMixins [ class "pagination-list" ]


paginationList : Tagger msg
paginationList =
    toPaginationList Html.ul


paginationEllipsis : List (Attribute msg) -> Html msg
paginationEllipsis attributes =
    Html.span
        (class "pagination-ellipsis" :: attributes)
        [ Html.text "…" ]
