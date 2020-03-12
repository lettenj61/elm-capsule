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

import Capsule.Builder exposing (Builder, withMixins)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (class)



-- MODAL


modal : Builder msg
modal =
    Html.div |> withMixins [ class "modal" ]


modalBackground : Builder msg
modalBackground =
    Html.div |> withMixins [ class "modal-background" ]


modalContent : Builder msg
modalContent =
    Html.div |> withMixins [ class "modal-content" ]


modalClose : List (Attribute msg) -> Html msg
modalClose attributes =
    Html.button
        (class "modal-close" :: attributes)
        []



-- MODAL CARD


modalCard : Builder msg
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


modalCardTitle : Builder msg
modalCardTitle =
    Html.p |> withMixins [ class "modal-card-title" ]


modalCardBody : Builder msg
modalCardBody =
    Html.section |> withMixins [ class "modal-card-body" ]


modalCardFoot : Builder msg
modalCardFoot =
    Html.footer |> withMixins [ class "modal-card-foot" ]
