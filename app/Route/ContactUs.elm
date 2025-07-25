module Route.ContactUs exposing (ActionData, Data, Model, Msg, route)

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
            (BackendTask.succeed "Contact K&D Pressure Washing LLC")


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
        , description = "Contact K&D Pressure Washing LLC for professional, eco-friendly pressure washing services in the Elgin area. Call 224-622-1040 or email us today!"
        , locale = Nothing
        , title = "Contact Us - K&D pressure washing LLC"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "Contact Us - K&D pressure washing LLC"
    , body = contactUsView
    }


contactUsView =
    [ div [ class "content contact-us-content" ]
        [ div [ class "contact-hero-container" ]
            [ h1 [ class "contact-headline" ] [ text "Get Your Free Estimate Today" ]
            , p [ class "contact-subtitle" ] [ text "Professional pressure washing services in Elgin and surrounding areas" ]
            , div [ class "contact-hero-icons" ]
                [ div [ class "contact-hero-card" ]
                    [ div [ class "contact-icon-container" ]
                        [ i [ class "fa fa-phone contact-icon" ] []
                        ]
                    , h3 [] [ text "Call Us" ]
                    , a [ href "tel:224-622-1040", class "contact-link" ] [ text "224-622-1040" ]
                    ]
                , div [ class "contact-hero-card" ]
                    [ div [ class "contact-icon-container" ]
                        [ i [ class "fa fa-envelope contact-icon" ] []
                        ]
                    , h3 [] [ text "Email Us" ]
                    , a [ href "mailto:Kanddpressurewashing@yahoo.com", class "contact-link" ] [ text "Kanddpressurewashing@yahoo.com" ]
                    ]
                ]
            ]
        , div [ class "contact-main-section" ]
            [ div [ class "contact-form-section" ]
                [ h2 [] [ text "Send Us a Message" ]
                , p [] [ text "Fill out the form below and we'll get back to you within 24 hours with your free estimate." ]
                , Html.form
                    [ name "contact"
                    , class "contact-form netlify"
                    , Html.Attributes.attribute "data-netlify" "true"
                    , Html.Attributes.attribute "action" "/contact-us"
                    , method "POST"
                    ]
                    [ input [ type_ "hidden", name "form-name", value "contact" ] []
                    , div [ class "form-row" ]
                        [ div [ class "form-group" ]
                            [ label [ for "name" ] [ text "Name *" ]
                            , input [ type_ "text", name "name", id "name", placeholder "Your Name", required True ] []
                            ]
                        , div [ class "form-group" ]
                            [ label [ for "email" ] [ text "Email *" ]
                            , input [ type_ "email", name "email", id "email", placeholder "your.email@example.com", required True ] []
                            ]
                        ]
                    , div [ class "form-row" ]
                        [ div [ class "form-group" ]
                            [ label [ for "phone" ] [ text "Phone" ]
                            , input [ type_ "tel", name "phone", id "phone", placeholder "(555) 123-4567" ] []
                            ]
                        , div [ class "form-group" ]
                            [ label [ for "service" ] [ text "Service Type" ]
                            , select [ name "service", id "service" ]
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
                        [ label [ for "message" ] [ text "Message" ]
                        , textarea [ name "message", id "message", placeholder "Tell us about your project...", rows 5 ] []
                        ]
                    , button [ type_ "submit", class "submit-btn" ] [ text "Send Message" ]
                    ]
                ]
            , div [ class "contact-info-section" ]
                [ h2 [] [ text "Contact Information" ]
                , div [ class "contact-info-cards" ]
                    [ contactInfoCard "fa-map-marker" "Address" [ "9N573 Koshare Trail", "Elgin, IL 60124" ]
                    , contactInfoCard "fa-clock-o" "Business Hours" [ "Monday - Friday: 8:00 AM - 6:00 PM", "Saturday: 9:00 AM - 4:00 PM", "Sunday: By Appointment" ]
                    , contactInfoCard "fa-shield" "Licensed & Insured" [ "Fully insured for your peace of mind", "EPA compliant practices", "Professional equipment & training" ]
                    ]
                ]
            ]
        , div [ class "contact-cta-section" ]
            [ h2 [] [ text "Why Choose K&D Pressure Washing?" ]
            , div [ class "contact-benefits" ]
                [ benefitItem "✓" "Free estimates with no obligation"
                , benefitItem "✓" "Eco-friendly cleaning solutions"
                , benefitItem "✓" "Advanced hot water systems"
                , benefitItem "✓" "Wastewater recovery technology"
                , benefitItem "✓" "Fully licensed and insured"
                , benefitItem "✓" "Local Elgin area experts"
                ]
            ]
        ]
    ]


contactInfoCard : String -> String -> List String -> Html msg
contactInfoCard iconClass title details =
    div [ class "contact-info-card" ]
        [ div [ class "contact-card-icon" ]
            [ i [ class ("fa " ++ iconClass) ] []
            ]
        , h3 [] [ text title ]
        , div [ class "contact-card-details" ]
            (List.map (\detail -> p [] [ text detail ]) details)
        ]


benefitItem : String -> String -> Html msg
benefitItem checkmark benefit =
    div [ class "benefit-item" ]
        [ span [ class "benefit-check" ] [ text checkmark ]
        , span [ class "benefit-text" ] [ text benefit ]
        ] 