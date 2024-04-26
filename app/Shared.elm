module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }


type Msg
    = SharedMsg SharedMsg
    | MenuClicked


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    { showMenu : Bool
    }


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( { showMenu = False }
    , Effect.none
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg globalMsg ->
            ( model, Effect.none )

        MenuClicked ->
            ( { model | showMenu = not model.showMenu }, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        [ Html.nav [] [ navView model ] |> Html.map toMsg
        , Html.main_ [] pageView.body
        , div [ class "footer-row " ] [ footerView ]
        ]
    , title = pageView.title
    }


navView model =
    div [ class "nav-container" ]
        ([ div [ class "topbar" ]
            [ a [] [ img [ class "logo", src "/full-logo.png" ] [] ]
            , div [ class "clickies" ]
                [ a [] [ div [ class "clickie" ] [ text "Main" ] ]
                , a [] [ div [ class "clickie" ] [ text "About Us" ] ]
                , a [] [ div [ class "clickie" ] [ text "Contact Us" ] ]
                ]
            , hamburgerOrX model
            ]
         ]
            ++ navItemsView model
        )


hamburgerOrX model =
    case model.showMenu of
        False ->
            button [ onClick MenuClicked, class "icon" ] [ i [ class "fa fa-bars" ] [] ]

        True ->
            button [ onClick MenuClicked, class "icon" ] [ i [ class "fa fa-close" ] [] ]


navItemsView model =
    case model.showMenu of
        False ->
            []

        True ->
            [ Route.Index |> Route.link [] [ div [ class "item" ] [ text "Main" ] ]
            , a [] [ div [ class "item" ] [ text "About Us" ] ]
            , a [] [ div [ class "item" ] [ text "Contact Us" ] ]
            ]


footerView =
    footer
        [ class "footer" ]
        [ img [ class "bottom-logo left", src "white_transparent.png" ] []
        , div
            [ class "contact-us" ]
            [ h4 [] [ text "Contact Us" ]
            , p [] [ text "9N573 Koshare Trail" ]
            , p [] [ text "Elgin, IL 60124" ]
            , p [] [ text "224-622-1040" ]
            , p [] [ text "Kanddpressurewashing@yahoo.com" ]
            ]
        , img [ class "bottom-logo right", src "white_transparent.png" ] []
        ]
