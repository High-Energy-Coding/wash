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
        ]
    ]


whatWeDoView =
    div [ class "wwd-container" ]
        [ div [ class "draw" ] [ img [ src "logo.png", class "draw-logo" ] [] ]
        , div [ class "why" ]
            [ h1 [] [ text "Power Wash Your Heart Out Today!" ]
            , p [] [ text "because kenny said so " ]
            ]
        ]


hero2 =
    [ img [ class "hero", src "/house.jpg" ] []
    , h1 [ class "headline" ] [ text "Power Wash", br [] [], text "with", br [] [], text "confidence" ]
    ]
