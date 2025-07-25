module Route.AboutUs exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (..)
import Html.Attributes exposing (..)
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
            (BackendTask.succeed "About K&D Pressure Washing LLC")


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
        , description = "Learn about K&D Pressure Washing LLC - your trusted partner for professional, eco-friendly pressure washing services in the Elgin area."
        , locale = Nothing
        , title = "About Us - K&D pressure washing LLC"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "About Us - K&D pressure washing LLC"
    , body = aboutUsView
    }


aboutUsView =
    [ div [ class "content about-us-content" ]
        [ div [ class "hero-container about-hero" ]
            [ img [ class "about-hero-image", src "/truck4.jpg" ] []
            , div [ class "about-hero-overlay" ]
                [ h1 [ class "about-headline" ] [ text "About K&D Pressure Washing LLC" ]
                , p [ class "about-subtitle" ] [ text "Professional. Reliable. Environmentally Conscious." ]
                ]
            ]
        , div [ class "about-content-section" ]
            [ div [ class "about-story" ]
                [ h2 [] [ text "Our Story" ]
                , p [] 
                    [ text "K&D Pressure Washing LLC was founded with a simple mission: to provide exceptional pressure washing services while protecting the environment we all share. Based in Elgin, Illinois, we've built our reputation on delivering consistent, high-quality results for both residential and commercial clients." ]
                , p []
                    [ text "What sets us apart is our commitment to using eco-friendly practices and state-of-the-art equipment, including hot water systems and wastewater recovery technology. We believe that powerful cleaning doesn't have to come at the expense of environmental responsibility." ]
                ]
            ]
        , div [ class "about-values-section" ]
            [ h2 [] [ text "Our Values" ]
            , div [ class "values-grid" ]
                [ valueCard "Quality" "We never compromise on the quality of our work. Every project receives our full attention and expertise."
                , valueCard "Environmental Responsibility" "Our EPA-friendly practices and wastewater recovery systems protect local ecosystems."
                , valueCard "Reliability" "Fully insured and committed to showing up on time, every time."
                , valueCard "Customer Satisfaction" "Your satisfaction is our priority. We work until you're completely happy with the results."
                ]
            ]
        , div [ class "about-team-section" ]
            [ h2 [] [ text "Why Choose K&D?" ]
            , div [ class "team-highlights" ]
                [ div [ class "highlight" ]
                    [ h3 [] [ text "Advanced Equipment" ]
                    , p [] [ text "Our hot water pressure washing systems and professional-grade equipment deliver superior results while using fewer chemicals." ]
                    ]
                , div [ class "highlight" ]
                    [ h3 [] [ text "Fully Insured" ]
                    , p [] [ text "Complete peace of mind with comprehensive insurance coverage for all our services." ]
                    ]
                , div [ class "highlight" ]
                    [ h3 [] [ text "Local Expertise" ]
                    , p [] [ text "As a local Elgin business, we understand the specific needs of properties in our area and are committed to serving our community." ]
                    ]
                ]
            ]
        , div [ class "about-contact-section" ]
            [ h2 [] [ text "Ready to Get Started?" ]
            , p [] [ text "Contact us today for a free estimate and discover why K&D Pressure Washing LLC is the trusted choice for professional cleaning services." ]
            , div [ class "contact-info" ]
                [ div [ class "contact-item" ]
                    [ strong [] [ text "Address: " ]
                    , text "9N573 Koshare Trail, Elgin, IL 60124"
                    ]
                , div [ class "contact-item" ]
                    [ strong [] [ text "Phone: " ]
                    , text "224-622-1040"
                    ]
                , div [ class "contact-item" ]
                    [ strong [] [ text "Email: " ]
                    , text "Kanddpressurewashing@yahoo.com"
                    ]
                ]
            ]
        ]
    ]


valueCard : String -> String -> Html msg
valueCard title description =
    div [ class "value-card" ]
        [ h3 [] [ text title ]
        , p [] [ text description ]
        ] 