module Capsule.Components.Modal exposing
    ( modal
    , modalBackground
    , modalCard
    , modalCardBody
    , modalCardFoot
    , modalCardHead
    , modalCardTitle
    , modalClose
    , modalContent
    )

import Capsule.Html exposing (Tagger, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- MODAL


modal : Tagger msg
modal =
    Html.div |> withMixins [ class "modal" ]


modalBackground : Tagger msg
modalBackground =
    Html.div |> withMixins [ class "modal-background" ]


modalContent : Tagger msg
modalContent =
    Html.div |> withMixins [ class "modal-content" ]


modalClose : List (Attribute msg) -> Html msg
modalClose attributes =
    Html.button
        (class "modal-close" :: attributes)
        []



-- MODAL CARD


modalCard : Tagger msg
modalCard =
    Html.div |> withMixins [ class "modal-card" ]


type alias ModalCardHeadProps msg =
    { title : Html msg
    , delete : Maybe (Html msg)
    }


modalCardHead : List (Attribute msg) -> ModalCardHeadProps msg -> Html msg
modalCardHead attributes props =
    Html.header
        (class "modal-card-head" :: attributes)
        [ props.title
        , case props.delete of
            Just delete ->
                delete

            Nothing ->
                Html.text ""
        ]


modalCardTitle : Tagger msg
modalCardTitle =
    Html.p |> withMixins [ class "modal-card-title" ]


modalCardBody : Tagger msg
modalCardBody =
    Html.section |> withMixins [ class "modal-card-body" ]


modalCardFoot : Tagger msg
modalCardFoot =
    Html.footer |> withMixins [ class "modal-card-foot" ]
