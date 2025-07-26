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
        , siteName = "K&D pressure washing LLC"
        , image =
            { url = [ "full-logo.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "K&D pressure washing LLC Logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Revitalize your property's appeal with professional pressure washing services from K&D Pressure Washing. Our expert team delivers thorough cleaning, removing dirt, grime, and stains, revealing the true beauty of your surfaces. Enhance curb appeal and protect your investment today!"
        , locale = Nothing
        , title = "K&D pressure washing LLC"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "K&D pressure washing LLC"
    , body = homeView
    }


homeView =
    [ div [ class "content" ]
        [ div [ class "hero-container" ] hero2
        , div [ class "row " ] [ whatWeDoView ]
        , div [] [ greenRowView ]
        , div [] [ contactUsView ]
        , div [] [ servicesView ]
        ]
    ]


greenRowView =
    div [ class "green-row" ]
        [ div [ class "green-container" ]
            [ div [ class "green-main-title" ]
                [ h2 [] [ text "Environmentally Conscious" ]
                ]
            , div [ class "green-main-content" ]
                [ greenSlotView "/system.jpeg" "Hot Water System" hotWaterBody
                , greenSlotView "/truck-back.jpeg" "EPA Friendly" epaFriendlyBody
                , greenSlotView "/system3.jpeg" "Waste Water Recovery" wasteWaterBody
                ]
            ]
        ]


greenSlotView imgUrl title body =
    div [ class "green-slot" ]
        [ div [ class "green-image" ] [ img [ class "green-img", src imgUrl ] [] ]
        , div [ class "green-title" ] [ h3 [] [ text title ] ]
        , div [ class "green-body" ] [ p [] [ text body ] ]
        ]


contactUsView =
    div [ class "contact-container" ]
        [ --  div [ class "whiteboard" ] [ img [ src "/whiteboard.jpg" ] [] ]
          h1 [ class "interested" ] [ text "Interested in connecting with us?" ]
        , div [ class "connect" ]
            [ Html.form
                [ name "connect"
                , class "contact-form netlify"
                , Html.Attributes.attribute "data-netlify" "true"
                , Html.Attributes.attribute "action" "/"
                , method "POST"
                ]
                [ input [ type_ "hidden", name "form-name", value "connect" ] []
                , div [ class "form-row" ]
                    [ div [ class "form-group" ]
                        [ label [ for "connect-name" ] [ text "Name *" ]
                        , input [ type_ "text", name "name", id "connect-name", placeholder "Your Name", required True ] []
                        ]
                    , div [ class "form-group" ]
                        [ label [ for "connect-email" ] [ text "Email *" ]
                        , input [ type_ "email", name "email", id "connect-email", placeholder "your.email@example.com", required True ] []
                        ]
                    ]
                , div [ class "form-row" ]
                    [ div [ class "form-group" ]
                        [ label [ for "connect-phone" ] [ text "Phone" ]
                        , input [ type_ "tel", name "phone", id "connect-phone", placeholder "(555) 123-4567" ] []
                        ]
                    , div [ class "form-group" ]
                        [ label [ for "connect-service" ] [ text "Service Type" ]
                        , select [ name "service", id "connect-service" ]
                            [ option [ value "" ] [ text "Select a service..." ]
                            , option [ value "residential" ] [ text "Residential Pressure Washing" ]
                            , option [ value "commercial" ] [ text "Commercial Pressure Washing" ]
                            , option [ value "deck" ] [ text "Deck Cleaning" ]
                            , option [ value "driveway" ] [ text "Driveway Cleaning" ]
                            , option [ value "other" ] [ text "Other" ]
                            ]
                        ]
                    ]
                , div [ class "form-group" ]
                    [ label [ for "connect-message" ] [ text "Message" ]
                    , textarea [ name "message", id "connect-message", placeholder "Tell us about your project...", rows 4 ] []
                    ]
                , button [ type_ "submit", class "submit-btn" ] [ text "Send Message" ]
                ]
            ]
        ]


servicesView =
    div [ class "services-container" ]
        [ service "1" "Commercial" "wash.jpg"
        , service "2" "Residential" "deck.jpg"
        , service "3" "Fully Insured" "house.jpeg"
        , service "4" "EPA Friendly" "on-driveway.jpg"
        ]


service count title imgUrl =
    let
        styleImgUrl =
            "url(\"" ++ imgUrl ++ "\")"
    in
    div [ class <| "service service-" ++ count ]
        [ div [ class <| "service-headline service-headline-" ++ count ]
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
    [ img [ class "hero", src "/truck_and_trailer.jpg" ] []
    , div [ class "hero-overlay" ]
        [ h1 [ class "homepage-h1" ] [ text "Professional Power Washing for Chicago's NW Suburbs" ]
        , p [ class "homepage-subheadline" ] [ text "Serving homes, businesses, and properties of all sizes" ]
        , Route.ContactUs |> Route.link [ class "homepage-cta-btn" ] [ text "Reach out today!" ]
        ]
    ]


whatWeDoView =
    div [ class "wwd-container" ]
        [ div [ class "draw" ] [ img [ src "logo2.png", class "draw-logo" ] [] ]
        , div [ class "why" ]
            [ p [] [ text "Welcome to K&D Pressure Washing LLC, where powerful, eco-conscious cleaning meets excellence. Experience spotless results with our state-of-the-art technology and dedicated professionals." ]
            ]
        ]


hotWaterBody =
    "Our advanced hot water pressure washing system harnesses the power of heated water to efficiently sanitize surfaces without the need for harsh chemicals. This not only ensures thorough cleaning but also minimizes environmental impact by reducing chemical runoff."


epaFriendlyBody =
    "We prioritize EPA-friendly practices by using biodegradable cleaning solutions and adhering to strict environmental regulations. Our commitment to eco-consciousness means cleaner results for your property while safeguarding the planet for future generations."


wasteWaterBody =
    "With our innovative wastewater recovery system, we capture and responsibly manage runoff from pressure washing activities. By preventing contaminated water from entering storm drains, we help protect local ecosystems and comply with environmental standards, ensuring sustainable cleaning practices."


loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
