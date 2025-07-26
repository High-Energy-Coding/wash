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
            (BackendTask.succeed "Welcome to K&D Pressure Washing LLC!")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "K&D pressure washing LLC"
        , image =
            { url = [ "logo3.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "K&D pressure washing LLC Logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Transform your property with K&D Pressure Washing LLC! Professional, eco-friendly pressure washing services serving Elgin and Chicago's Northwest Suburbs. Hot water systems, wastewater recovery, and outstanding results guaranteed."
        , locale = Nothing
        , title = "K&D Pressure Washing LLC - Professional Power Washing Services | Elgin, IL"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "K&D Pressure Washing LLC - Professional Power Washing Services"
    , body = homeView
    }


homeView =
    [ div [ class "content" ]
        [ div [ class "hero-container" ] hero2
        , socialProofSection
        , div [ class "row " ] [ whatWeDoView ]
        , beforeAfterSection
        , div [] [ greenRowView ]
        , quickStatsSection
        , div [] [ contactUsView ]
        , div [] [ servicesView ]
        , testimonialCarousel
        ]
    ]


socialProofSection =
    div [ class "social-proof-section" ]
        [ div [ class "social-proof-container" ]
            [ div [ class "social-proof-content" ]
                [ h3 [] [ text "Trusted by 500+ Happy Customers in Elgin & Surrounding Areas" ]
                , div [ class "social-proof-stats" ]
                    [ div [ class "proof-stat" ]
                        [ span [ class "proof-number" ] [ text "5★" ]
                        , span [ class "proof-label" ] [ text "Average Rating" ]
                        ]
                    , div [ class "proof-stat" ]
                        [ span [ class "proof-number" ] [ text "500+" ]
                        , span [ class "proof-label" ] [ text "Properties Cleaned" ]
                        ]
                    , div [ class "proof-stat" ]
                        [ span [ class "proof-number" ] [ text "100%" ]
                        , span [ class "proof-label" ] [ text "Satisfaction Rate" ]
                        ]
                    ]
                , p [ class "social-proof-text" ]
                    [ text "Join hundreds of satisfied customers who trust us with their most valuable asset - their property." ]
                ]
            ]
        ]


beforeAfterSection =
    div [ class "before-after-section" ]
        [ h2 [] [ text "See the K&D Difference" ]
        , p [ class "before-after-subtitle" ]
            [ text "Real results from real customers in our community" ]
        , div [ class "before-after-grid" ]
            [ beforeAfterCard "/deck.jpg" "Deck Transformation" "From weathered gray to beautiful natural wood"
            , beforeAfterCard "/driveway.png" "Driveway Restoration" "Removed years of stains and buildup"
            , beforeAfterCard "/house.jpg" "House Washing" "Restored the home's original beauty"
            ]
        , div [ class "before-after-cta" ]
            [ Route.ContactUs |> Route.link [ class "before-after-btn" ] [ text "Get Your Free Estimate" ]
            ]
        ]


beforeAfterCard : String -> String -> String -> Html msg
beforeAfterCard imgSrc title description =
    div [ class "before-after-card" ]
        [ div [ class "before-after-image" ]
            [ img [ src imgSrc, alt title ] []
            , div [ class "before-after-overlay" ]
                [ div [ class "overlay-content" ]
                    [ h4 [] [ text title ]
                    , p [] [ text description ]
                    ]
                ]
            ]
        ]


quickStatsSection =
    div [ class "quick-stats-section" ]
        [ div [ class "quick-stats-container" ]
            [ div [ class "quick-stats-header" ]
                [ h2 [] [ text "Why Elgin Chooses K&D" ]
                , p [] [ text "The numbers speak for themselves" ]
                ]
            , div [ class "quick-stats-grid" ]
                [ quickStat "🏆" "5 Years" "Serving the Community"
                , quickStat "🚛" "Full Service" "Mobile Equipment"
                , quickStat "🌱" "Eco-Friendly" "EPA Compliant"
                , quickStat "💼" "Fully Insured" "Complete Protection"
                ]
            ]
        ]


quickStat : String -> String -> String -> Html msg
quickStat icon stat label =
    div [ class "quick-stat-card" ]
        [ div [ class "quick-stat-icon" ] [ text icon ]
        , div [ class "quick-stat-number" ] [ text stat ]
        , div [ class "quick-stat-label" ] [ text label ]
        ]


testimonialCarousel =
    div [ class "testimonial-carousel-section" ]
        [ h2 [] [ text "What Our Neighbors Are Saying" ]
        , div [ class "testimonial-carousel" ]
            [ testimonialCarouselCard
                "K&D did an amazing job on our deck and driveway! It looks like new construction. Professional, punctual, and the price was very fair. Highly recommend!"
                "Mike & Susan T."
                "Homeowners in Elgin"
            , testimonialCarouselCard
                "Best decision we made for our commercial property. The hot water system they use is incredible - removed stains we thought were permanent."
                "Jennifer R."
                "Business Owner"
            , testimonialCarouselCard
                "Love that they're environmentally conscious with their wastewater recovery system. Great results and peace of mind!"
                "David L."
                "Satisfied Customer"
            ]
        ]


testimonialCarouselCard : String -> String -> String -> Html msg
testimonialCarouselCard quote author role =
    div [ class "testimonial-carousel-card" ]
        [ div [ class "testimonial-quote-mark" ] [ text "\"" ]
        , p [ class "testimonial-carousel-quote" ] [ text quote ]
        , div [ class "testimonial-carousel-author" ]
            [ strong [] [ text author ]
            , span [] [ text (" - " ++ role) ]
            ]
        , div [ class "testimonial-stars" ] [ text "⭐⭐⭐⭐⭐" ]
        ]


greenRowView =
    div [ class "green-row" ]
        [ div [ class "green-container" ]
            [ div [ class "green-main-title" ]
                [ h2 [] [ text "Advanced Technology, Environmental Responsibility" ]
                , p [ class "green-subtitle" ] [ text "State-of-the-art equipment that protects your property and our planet" ]
                ]
            , div [ class "green-main-content" ]
                [ greenSlotView "/system.jpeg" "Hot Water Systems" hotWaterBody
                , greenSlotView "/truck-back.jpeg" "EPA Friendly Practices" epaFriendlyBody
                , greenSlotView "/system3.jpeg" "Wastewater Recovery" wasteWaterBody
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
        [ div [ class "contact-header" ]
            [ h1 [ class "interested" ] [ text "Ready to Transform Your Property?" ]
            , p [ class "contact-subheader" ]
                [ text "Get your free estimate today and join hundreds of satisfied customers in the Elgin area!" ]
            ]
        , div [ class "contact-methods" ]
            [ div [ class "contact-method-card" ]
                [ i [ class "fa fa-phone contact-method-icon" ] []
                , h3 [] [ text "Call Us Today" ]
                , p [] [ text "224-622-1040" ]
                , p [ class "contact-method-note" ] [ text "Quick response guaranteed" ]
                ]
            , div [ class "contact-method-card" ]
                [ i [ class "fa fa-envelope contact-method-icon" ] []
                , h3 [] [ text "Email Us" ]
                , p [] [ text "Kanddpressurewashing@yahoo.com" ]
                , p [ class "contact-method-note" ] [ text "Detailed quotes available" ]
                ]
            ]
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
                    [ label [ for "connect-message" ] [ text "Tell us about your project" ]
                    , textarea [ name "message", id "connect-message", placeholder "Describe what you'd like cleaned...", rows 4 ] []
                    ]
                , button [ type_ "submit", class "submit-btn" ] [ text "Get My Free Estimate" ]
                ]
            ]
        ]


servicesView =
    div [ class "services-container" ]
        [ service "1" "Residential" "deck.jpg"
        , service "2" "Commercial" "wash.jpg"
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
        [ h1 [ class "homepage-h1" ] [ text "Professional Pressure Washing That Makes Your Property Shine" ]
        , p [ class "homepage-subheadline" ] [ text "Serving Elgin & Chicago's Northwest Suburbs with Advanced Hot Water Systems & Eco-Friendly Practices" ]
        , div [ class "hero-cta-buttons" ]
            [ Route.ContactUs |> Route.link [ class "homepage-cta-btn primary" ] [ text "Get Free Estimate" ]
            , a [ href "tel:224-622-1040", class "homepage-cta-btn secondary" ]
                [ i [ class "fa fa-phone" ] []
                , text " Call Now"
                ]
            ]
        , div [ class "hero-trust-badges" ]
            [ div [ class "trust-badge" ]
                [ i [ class "fa fa-shield" ] []
                , span [] [ text "Fully Insured" ]
                ]
            , div [ class "trust-badge" ]
                [ i [ class "fa fa-leaf" ] []
                , span [] [ text "Eco-Friendly" ]
                ]
            , div [ class "trust-badge" ]
                [ i [ class "fa fa-star" ] []
                , span [] [ text "5-Star Rated" ]
                ]
            ]
        ]
    ]


whatWeDoView =
    div [ class "wwd-container" ]
        [ div [ class "draw" ] [ img [ src "logo2.png", class "draw-logo" ] [] ]
        , div [ class "why" ]
            [ h2 [] [ text "Why Choose K&D Pressure Washing?" ]
            , p [] [ text "We're not just another pressure washing company - we're your neighbors in Elgin who take pride in transforming properties with cutting-edge technology and environmental responsibility." ]
            , div [ class "why-features" ]
                [ feature "✓" "Advanced hot water systems for superior cleaning"
                , feature "✓" "EPA-compliant wastewater recovery technology"
                , feature "✓" "Fully insured with comprehensive coverage"
                , feature "✓" "Local expertise serving Chicago's Northwest Suburbs"
                ]
            , Route.AboutUs |> Route.link [ class "learn-more-btn" ] [ text "Learn More About Us" ]
            ]
        ]


feature : String -> String -> Html msg
feature icon text =
    div [ class "feature-item" ]
        [ span [ class "feature-icon" ] [ Html.text icon ]
        , span [ class "feature-text" ] [ Html.text text ]
        ]


hotWaterBody =
    "Our advanced hot water pressure washing system harnesses the power of heated water to efficiently sanitize surfaces without the need for harsh chemicals. This not only ensures thorough cleaning but also minimizes environmental impact by reducing chemical runoff."


epaFriendlyBody =
    "We prioritize EPA-friendly practices by using biodegradable cleaning solutions and adhering to strict environmental regulations. Our commitment to eco-consciousness means cleaner results for your property while safeguarding the planet for future generations."


wasteWaterBody =
    "With our innovative wastewater recovery system, we capture and responsibly manage runoff from pressure washing activities. By preventing contaminated water from entering storm drains, we help protect local ecosystems and comply with environmental standards, ensuring sustainable cleaning practices."
