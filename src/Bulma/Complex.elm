module Bulma.Complex exposing
    ( breadcrumb, breadcrumbItem
    , CardHeaderProps, CardImageProps, CardProps, card, defaultCard
    , setCardHeader, setCardImage, setCardContent, setCardFooter
    , cardHeaderTitle, asCardHeaderIcon, cardFooterItem
    , DropdownProps, defaultDropdown, dropdown, dropdownItem, setDropdownContent, setDropdownTrigger
    , menu, menuLabel, menuList, menuAnchorItem
    , MessageProps, defaultMessage, message, setMessageHeader, setMessageOnDelete, setMessageBody
    , NavbarBrandProps, NavbarProps, defaultNavbar, navbar, navbarWithMenu, navbarItem, navbarDivider
    , setNavbarBrand, setNavbarMenuOptions, setNavbarStart, setNavbarEnd
    , PaginationProps, defaultPagination, pagination, paginationLink, paginationEllipsis
    , setPaginationNext, setPaginationPrevious, setPaginationList
    , tabs, tabItem
    )

{-| Bulma complex components.


# Breadcrumb

@docs breadcrumb, breadcrumbItem


# Card

@docs CardHeaderProps, CardImageProps, CardProps, card, defaultCard
@docs setCardHeader, setCardImage, setCardContent, setCardFooter
@docs cardHeaderTitle, asCardHeaderIcon, cardFooterItem


# Dropdown

@docs DropdownProps, defaultDropdown, dropdown, dropdownItem, setDropdownContent, setDropdownTrigger


# Menu

@docs menu, menuLabel, menuList, menuAnchorItem


# Message

@docs MessageProps, defaultMessage, message, setMessageHeader, setMessageOnDelete, setMessageBody


# Modal

Not implemented.


# Navbar

@docs NavbarBrandProps, NavbarProps, defaultNavbar, navbar, navbarWithMenu, navbarItem, navbarDivider
@docs setNavbarBrand, setNavbarMenuOptions, setNavbarStart, setNavbarEnd


# Pagination

@docs PaginationProps, defaultPagination, pagination, paginationLink, paginationEllipsis
@docs setPaginationNext, setPaginationPrevious, setPaginationList


# Panel

Not implemented.


# Tabs

@docs tabs, tabItem

-}

import Bulma.Internal exposing (renderMaybe, styled_)
import Html exposing (Attribute, Html)
import Html.Attributes exposing (attribute, class)


{-| -}
breadcrumb : List (Attribute msg) -> List (Html msg) -> Html msg
breadcrumb attributes children =
    Html.nav
        (class "breadcrumb"
            :: attribute "aria-label" "breadcrumbs"
            :: attributes
        )
        [ Html.ul []
            children
        ]


{-| -}
breadcrumbItem : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
breadcrumbItem =
    anchorListItem


{-| -}
navbar : List (Attribute msg) -> List (Html msg) -> Html msg
navbar attributes children =
    let
        baseAttributes =
            [ class "navbar"
            , attribute "role" "navigation"
            , attribute "aria-label" "navigation"
            ]
    in
    Html.nav
        (baseAttributes ++ attributes)
        children


{-| -}
type alias NavbarBrandProps msg =
    { logo : Html msg
    , burger : List (Attribute msg)
    }


{-| -}
type alias NavbarProps msg =
    { brand : Maybe (NavbarBrandProps msg)
    , menuOptions : List (Attribute msg)
    , menuStart : List (Html msg)
    , menuEnd : List (Html msg)
    }


{-| -}
defaultNavbar : NavbarProps msg
defaultNavbar =
    { brand = Nothing
    , menuOptions = []
    , menuStart = []
    , menuEnd = []
    }


{-| -}
navbarWithMenu : List (Attribute msg) -> NavbarProps msg -> Html msg
navbarWithMenu attributes props =
    navbar attributes
        [ case props.brand of
            Just { logo, burger } ->
                let
                    span =
                        Html.span
                            [ attribute "aria-hidden" "true" ]
                            []
                in
                Html.div
                    [ class "navbar-brand" ]
                    [ logo
                    , Html.a
                        (class "navbar-burger"
                            :: attribute "role" "button"
                            :: attribute "aria-label" "menu"
                            :: burger
                        )
                        [ span
                        , span
                        , span
                        ]
                    ]

            Nothing ->
                Html.text ""
        , Html.div
            (class "navbar-menu" :: props.menuOptions)
            [ case props.menuStart of
                [] ->
                    Html.text ""

                menuStart ->
                    Html.div
                        [ class "navbar-start" ]
                        menuStart
            , case props.menuEnd of
                [] ->
                    Html.text ""

                menuEnd ->
                    Html.div
                        [ class "navbar-end" ]
                        menuEnd
            ]
        ]


{-| -}
setNavbarMenuOptions : List (Attribute msg) -> NavbarProps msg -> NavbarProps msg
setNavbarMenuOptions options props =
    { props
        | menuOptions = options
    }


{-| -}
setNavbarBrand : NavbarBrandProps msg -> NavbarProps msg -> NavbarProps msg
setNavbarBrand brand props =
    { props
        | brand = Just brand
    }


{-| -}
setNavbarStart : List (Html msg) -> NavbarProps msg -> NavbarProps msg
setNavbarStart menuStart props =
    { props
        | menuStart = menuStart
    }


{-| -}
setNavbarEnd : List (Html msg) -> NavbarProps msg -> NavbarProps msg
setNavbarEnd menuEnd props =
    { props
        | menuEnd = menuEnd
    }


{-| -}
navbarItem :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
navbarItem h =
    styled_ h "navbar-item"


{-| -}
navbarDivider : Html msg
navbarDivider =
    Html.hr [ class "navbar-divider" ] []


{-| -}
menu : List (Attribute msg) -> List (Html msg) -> Html msg
menu =
    styled_ Html.aside "menu"


{-| -}
menuLabel : List (Attribute msg) -> List (Html msg) -> Html msg
menuLabel =
    styled_ Html.p "menu-label"


{-| -}
menuList : List (Attribute msg) -> List (Html msg) -> Html msg
menuList =
    styled_ Html.ul "menu-list"


{-| -}
menuAnchorItem : List (Attribute msg) -> List (Html msg) -> Html msg
menuAnchorItem attributes children =
    Html.li
        []
        [ Html.a attributes children
        ]


{-| -}
type alias MessageProps msg =
    { header : List (Html msg)
    , delete : Maybe (Html msg)
    , body : List (Html msg)
    }


{-| -}
defaultMessage : MessageProps msg
defaultMessage =
    { header = []
    , delete = Nothing
    , body = []
    }


{-| -}
setMessageHeader : List (Html msg) -> MessageProps msg -> MessageProps msg
setMessageHeader messageHeader props =
    { props
        | header = messageHeader
    }


{-| -}
setMessageOnDelete : Html msg -> MessageProps msg -> MessageProps msg
setMessageOnDelete deleteElem props =
    { props
        | delete = Just deleteElem
    }


{-| -}
setMessageBody : List (Html msg) -> MessageProps msg -> MessageProps msg
setMessageBody messageBody props =
    { props
        | body = messageBody
    }


{-| -}
message : List (Attribute msg) -> MessageProps msg -> Html msg
message attributes props =
    let
        deleteButton =
            props.delete
                |> Maybe.withDefault (Html.text "")

        messageHeader =
            case props.header of
                [] ->
                    Html.text ""

                headerWithContent ->
                    Html.div
                        [ class "message-header" ]
                        (headerWithContent ++ [ deleteButton ])
    in
    styled_ Html.article
        "message"
        attributes
        [ messageHeader
        , Html.div
            [ class "message-body" ]
            props.body
        ]


{-| -}
tabs : List (Attribute msg) -> List (Html msg) -> Html msg
tabs attributes children =
    Html.div
        (class "tabs" :: attributes)
        [ Html.ul
            []
            children
        ]


{-| -}
tabItem : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
tabItem =
    anchorListItem


{-| -}
type alias PaginationProps msg =
    { previous : Maybe (Html msg)
    , next : Maybe (Html msg)
    , list : List (Html msg)
    }


{-| -}
defaultPagination : PaginationProps msg
defaultPagination =
    { previous = Nothing
    , next = Nothing
    , list = []
    }


{-| -}
pagination : PaginationProps msg -> Html msg
pagination props =
    Html.nav
        [ class "pagination"
        , attribute "role" "pagination"
        , attribute "aria-label" "pagination"
        ]
        [ case props.previous of
            Just prev ->
                prev

            Nothing ->
                Html.text ""
        , case props.next of
            Just next ->
                next

            Nothing ->
                Html.text ""
        , Html.ul
            [ class "pagination-list" ]
            props.list
        ]


{-| -}
setPaginationPrevious : Html msg -> PaginationProps msg -> PaginationProps msg
setPaginationPrevious previous props =
    { props
        | previous = Just previous
    }


{-| -}
setPaginationNext : Html msg -> PaginationProps msg -> PaginationProps msg
setPaginationNext next props =
    { props
        | next = Just next
    }


{-| -}
setPaginationList : List (Html msg) -> PaginationProps msg -> PaginationProps msg
setPaginationList paginationList props =
    { props
        | list = paginationList
    }


{-| -}
paginationEllipsis : List (Attribute msg) -> List (Html msg) -> Html msg
paginationEllipsis attributes children =
    Html.li
        []
        [ Html.span
            (class "pagination-ellipsis" :: attributes)
            children
        ]


{-| -}
paginationLink : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
paginationLink isCurrent attributes children =
    let
        activeClass =
            if isCurrent then
                "pagination-link is-current"

            else
                "pagination-link"
    in
    Html.li
        []
        [ Html.a
            (class activeClass :: attributes)
            children
        ]


{-| -}
type alias CardHeaderProps msg =
    { title : Html msg
    , icon : Maybe (Html msg)
    }


type alias CardImageProps msg =
    { figure : List (Attribute msg)
    , image : List (Attribute msg)
    }


{-| -}
type alias CardProps msg =
    { header : Maybe (CardHeaderProps msg)
    , image : Maybe (CardImageProps msg)
    , content : List (Html msg)
    , footer : List (Html msg)
    }


{-| -}
defaultCard : CardProps msg
defaultCard =
    { header = Nothing
    , image = Nothing
    , content = []
    , footer = []
    }


{-| -}
card : CardProps msg -> Html msg
card props =
    Html.div
        [ class "card" ]
        [ case props.header of
            Just header ->
                Html.header
                    [ class "card-header" ]
                    [ header.title
                    , renderMaybe header.icon
                    ]

            Nothing ->
                Html.text ""
        , props.image
            |> Maybe.map
                (\{ figure, image } ->
                    Html.div
                        [ class "card-image" ]
                        [ Html.figure
                            figure
                            [ Html.img image []
                            ]
                        ]
                )
            |> renderMaybe
        , case props.content of
            [] ->
                Html.text ""

            content ->
                Html.div
                    [ class "card-content" ]
                    content
        , case props.footer of
            [] ->
                Html.text ""

            footer ->
                Html.footer
                    [ class "card-footer" ]
                    footer
        ]


{-| -}
setCardHeader : CardHeaderProps msg -> CardProps msg -> CardProps msg
setCardHeader header props =
    { props
        | header = Just header
    }


{-| -}
setCardImage : CardImageProps msg -> CardProps msg -> CardProps msg
setCardImage image props =
    { props
        | image = Just image
    }


{-| -}
setCardContent : List (Html msg) -> CardProps msg -> CardProps msg
setCardContent content props =
    { props
        | content = content
    }


{-| -}
setCardFooter : List (Html msg) -> CardProps msg -> CardProps msg
setCardFooter footer props =
    { props
        | footer = footer
    }


{-| -}
cardHeaderTitle : List (Attribute msg) -> List (Html msg) -> Html msg
cardHeaderTitle =
    styled_ Html.p "card-header-title"


{-| -}
asCardHeaderIcon :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
asCardHeaderIcon h =
    styled_ h "card-header-icon"


{-| -}
cardFooterItem : List (Attribute msg) -> List (Html msg) -> Html msg
cardFooterItem =
    styled_ Html.a "card-footer"


{-| Structure for a dropdown component.
-}
type alias DropdownProps msg =
    { trigger : Maybe (Html msg)
    , content : List (Html msg)
    }


{-| Initial option for dropdowns.
-}
defaultDropdown : DropdownProps msg
defaultDropdown =
    { trigger = Nothing
    , content = []
    }


{-| -}
setDropdownTrigger : Html msg -> DropdownProps msg -> DropdownProps msg
setDropdownTrigger trigger props =
    { props
        | trigger = Just trigger
    }


{-| -}
setDropdownContent : List (Html msg) -> DropdownProps msg -> DropdownProps msg
setDropdownContent content props =
    { props
        | content = content
    }


{-| Render a dropdown.

    import Bulma.Complex as B
    import Bulma.Element as B
    import Html exposing (Html, p, text)
    import Html.Attributes exposing (class)
    import Html.Events exposing (onClick)

    type alias Model =
        { isOpen : Bool
        }

    type Msg
        = ToggleDropdown

    view : Model -> Html Msg
    view { isOpen } =
        B.dropdown
            isOpen
            -- State
            []
            -- Attributes
            (B.defaultDropdown
                |> B.setDropdownTrigger
                    (B.button
                        [ onClick ToggleDropdown
                        ]
                        [ text "Push me!" ]
                    )
                |> B.setDropdownContent
                    [ p [] [ text "I am hidden by default!" ]
                    ]
            )

-}
dropdown : Bool -> List (Attribute msg) -> DropdownProps msg -> Html msg
dropdown isActive attributes props =
    let
        activeClass =
            if isActive then
                "dropdown is-active"

            else
                "dropdown"
    in
    Html.div
        (class activeClass :: attributes)
        [ Html.div
            [ class "dropdown-trigger" ]
            [ props.trigger
                |> Maybe.withDefault (Html.text "")
            ]
        , Html.div
            [ class "dropdown-menu" ]
            [ Html.div
                [ class "dropdown-content" ]
                props.content
            ]
        ]


{-| -}
dropdownItem :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
dropdownItem h =
    styled_ h "dropdown-item"



-- HELPERS


anchorListItem : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
anchorListItem isActive attributes children =
    let
        activeClass =
            class <|
                if isActive then
                    "is-active"

                else
                    ""
    in
    Html.li
        [ activeClass ]
        [ Html.a
            attributes
            children
        ]
