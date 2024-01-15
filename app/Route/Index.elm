module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    { message : String
    }


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data
        |> BackendTask.andMap
            (BackendTask.succeed "Hello!")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Albro Power Washing"
        , image =
            { url = [ "images", "icon-png.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "Albro Power Washing Logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Albro Power Washing"
        , locale = Nothing
        , title = "Albro Power Washing"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "Albro Power Washing"
    , body = homeView
    }


homeView =
    [ div [ class "content" ]
        [ div [ class "hero-container" ] hero2
        , div [ class "row " ] [ whatWeDoView ]
        , div [] [ servicesView ]
        , div [] [ contactUsView ]
        ]
    ]


contactUsView =
    div [ class "contact-container" ]
        [ --  div [ class "whiteboard" ] [ img [ src "/whiteboard.jpg" ] [] ]
          h1 [ class "interested" ] [ text "Interested in connecting with us?" ]
        , div [ class "connect" ]
            [ Html.form
                [ name "connect"
                , class "netlify"
                , Html.Attributes.attribute "data-netlify" "true"
                , Html.Attributes.attribute "action" "/"
                , method "POST"
                ]
                [ input [ type_ "hidden", name "form-name", value "connect" ] []
                , div [ class "typings" ] [ input [ type_ "text", name "name", placeholder "Name" ] [] ]
                , div [ class "typings" ] [ input [ type_ "email", name "email", placeholder "E-mail" ] [] ]
                , div [ class "typings" ] [ input [ type_ "tel", name "phone", placeholder "Phone" ] [] ]
                , div [ class "typings" ] [ input [ type_ "text", name "message", placeholder "Message", class "message" ] [] ]
                , button [ type_ "submit" ] [ text "Send" ]
                ]
            ]
        ]


servicesView =
    div [ class "services-container" ]
        [ service "1" "Service 1" "wash.jpg"
        , service "2" "Service 2" "deck.jpg"
        , service "3" "Service 3" "house.jpeg"
        , service "4" "Service 4" "driveway.png"
        ]


service count title imgUrl =
    let
        styleImgUrl =
            "url(\"" ++ imgUrl ++ "\")"
    in
    div [ class <| "service service-" ++ count ]
        [ div [ class "service-headline" ]
            [ h2 [] [ text title ]
            ]
        , div [ class "service-body-container" ]
            [ div
                [ class <| "service-body service-body-" ++ count
                , style "background-image" styleImgUrl
                ]
                []
            ]
        ]


hero2 =
    [ img [ class "hero", src "/house.jpg" ] []
    , h1 [ class "headline" ]
        [ span [ class "uno" ] [ text "Redefining Clean." ]
        , br [] []
        , span [ class "dos" ] [ text "Where Power" ]
        , br [] []
        , span [ class "tres" ] [ text "Meets Precision." ]
        ]
    ]


whatWeDoView =
    div [ class "wwd-container" ]
        [ div [ class "draw" ] [ img [ src "full-logo.png", class "draw-logo" ] [] ]
        , div [ class "why" ]
            [ p [] [ text "Welcome to Albro Power Wash, your top choice for powerful cleaning services. We specialize in eliminating dirt and grime with precision and state-of-the-art technology. Our dedicated professionals deliver reliable and passionate cleaning solutions. Choose us for a spotless clean that reflects our unwavering commitment to excellence. Experience the difference at Albro Power Washing, where power meets cleanliness." ]
            ]
        ]
