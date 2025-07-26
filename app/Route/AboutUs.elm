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
        , description = "Meet the team behind K&D Pressure Washing LLC - your trusted local pressure washing experts serving Elgin and surrounding areas with professional, eco-friendly cleaning services."
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
                [ h1 [ class "about-headline" ] [ text "Meet K&D Pressure Washing LLC" ]
                , p [ class "about-subtitle" ] [ text "Your Local Pressure Washing Experts Since Day One" ]
                ]
            ]
        , div [ class "about-personal-story" ]
            [ div [ class "story-container" ]
                [ div [ class "story-text" ]
                    [ h2 [] [ text "Our Journey Started with a Vision" ]
                    , p []
                        [ text "What began as a passion for transforming properties has evolved into K&D Pressure Washing LLC - your trusted partner in the Elgin community. We're not just another cleaning service; we're your neighbors who take pride in making your property shine." ]
                    , p []
                        [ text "Every job we take on is personal to us. Whether it's restoring your deck to its former glory, cleaning your driveway to look brand new, or preparing your business for customers, we approach each project with the same dedication we'd give our own property." ]
                    ]
                , div [ class "story-image" ]
                    [ img [ src "/truck-and-trailer.jpeg", alt "K&D Pressure Washing truck and equipment" ] []
                    ]
                ]
            ]
        , photoGallerySection
        , testimonialSection
        , div [ class "about-values-section" ]
            [ h2 [] [ text "What Drives Us Every Day" ]
            , div [ class "values-grid" ]
                [ valueCard "🏆" "Uncompromising Quality" "We never cut corners. Every surface gets our full attention, ensuring results that exceed your expectations every single time."
                , valueCard "🌱" "Environmental Stewardship" "Our advanced wastewater recovery systems and eco-friendly practices protect the environment we all share."
                , valueCard "⏰" "Reliability You Can Count On" "Fully insured and committed to punctuality. When we say we'll be there, we'll be there - ready to work."
                , valueCard "😊" "Your Satisfaction is Everything" "We're not done until you're absolutely thrilled with the results. Your smile at the end is what drives us."
                ]
            ]
        , equipmentShowcaseSection
        , communitySection
        , div [ class "about-contact-section" ]
            [ h2 [] [ text "Ready to See the K&D Difference?" ]
            , p [] [ text "Join hundreds of satisfied customers who trust K&D Pressure Washing LLC. Get your free estimate today and discover why we're the preferred choice in Elgin and surrounding areas." ]
            , div [ class "contact-cta-container" ]
                [ Route.ContactUs |> Route.link [ class "contact-cta-btn" ] [ text "Get Your Free Estimate" ]
                , div [ class "contact-phone" ]
                    [ i [ class "fa fa-phone" ] []
                    , span [] [ text "Call us: 224-622-1040" ]
                    ]
                ]
            , div [ class "contact-info" ]
                [ div [ class "contact-item" ]
                    [ i [ class "fa fa-map-marker" ] []
                    , span [] [ text "9N573 Koshare Trail, Elgin, IL 60124" ]
                    ]
                , div [ class "contact-item" ]
                    [ i [ class "fa fa-envelope" ] []
                    , span [] [ text "Kanddpressurewashing@yahoo.com" ]
                    ]
                ]
            ]
        ]
    ]


photoGallerySection =
    div [ class "photo-gallery-section" ]
        [ h2 [] [ text "Our Work Speaks for Itself" ]
        , p [ class "gallery-subtitle" ] [ text "Real transformations from our satisfied customers" ]
        , div [ class "gallery-grid" ]
            [ galleryItem "/deck.jpg" "Deck Restoration" "Beautiful natural wood restored"
            , galleryItem "/driveway.png" "Driveway Cleaning" "Clean, like-new appearance"
            , galleryItem "/house.jpg" "House Washing" "Fresh, clean exterior"
            , galleryItem "/on-driveway.jpg" "Commercial Services" "Professional business cleaning"
            , galleryItem "/wash.jpg" "Deep Cleaning" "Thorough, lasting results"
            , galleryItem "/system2.jpeg" "Professional Equipment" "State-of-the-art systems"
            ]
        ]


galleryItem : String -> String -> String -> Html msg
galleryItem imgSrc title description =
    div [ class "gallery-item" ]
        [ div [ class "gallery-image-container" ]
            [ img [ src imgSrc, alt title ] []
            ]
        , div [ class "gallery-caption" ]
            [ h4 [] [ text title ]
            , p [] [ text description ]
            ]
        ]


testimonialSection =
    div [ class "testimonial-section" ]
        [ h2 [] [ text "What Our Customers Say" ]
        , div [ class "testimonials-container" ]
            [ testimonialCard
                "K&D transformed our deck from embarrassing to entertaining! The hot water system they use made all the difference. Highly recommend!"
                "Sarah M."
                "Homeowner in Elgin"
                "⭐⭐⭐⭐⭐"
            , testimonialCard
                "Professional, on time, and incredible results. Our commercial property looks brand new. The wastewater recovery system shows they really care about the environment."
                "Mike R."
                "Business Owner"
                "⭐⭐⭐⭐⭐"
            , testimonialCard
                "Best pressure washing service in the area! They cleaned our driveway, walkway, and house siding. Everything looks amazing and the price was very fair."
                "Jennifer L."
                "Satisfied Customer"
                "⭐⭐⭐⭐⭐"
            ]
        ]


testimonialCard : String -> String -> String -> String -> Html msg
testimonialCard quote author role stars =
    div [ class "testimonial-card" ]
        [ div [ class "testimonial-stars" ] [ text stars ]
        , p [ class "testimonial-quote" ] [ text ("\"" ++ quote ++ "\"") ]
        , div [ class "testimonial-author" ]
            [ strong [] [ text author ]
            , span [] [ text (" - " ++ role) ]
            ]
        ]


equipmentShowcaseSection =
    div [ class "equipment-showcase" ]
        [ h2 [] [ text "Advanced Equipment, Superior Results" ]
        , div [ class "equipment-grid" ]
            [ equipmentCard "/system.jpeg" "Hot Water Systems" "Our heated pressure washing delivers deeper cleaning with fewer chemicals, perfect for tough stains and sanitization."
            , equipmentCard "/system3.jpeg" "Wastewater Recovery" "Environmental responsibility meets powerful cleaning. We capture and properly dispose of all wastewater."
            , equipmentCard "/truck-back.jpeg" "Professional Setup" "Fully equipped mobile units bring everything needed for comprehensive cleaning to your location."
            ]
        ]


equipmentCard : String -> String -> String -> Html msg
equipmentCard imgSrc title description =
    div [ class "equipment-card" ]
        [ img [ src imgSrc, alt title ] []
        , div [ class "equipment-content" ]
            [ h3 [] [ text title ]
            , p [] [ text description ]
            ]
        ]


communitySection =
    div [ class "community-section" ]
        [ div [ class "community-container" ]
            [ div [ class "community-text" ]
                [ h2 [] [ text "Proud to Serve Our Elgin Community" ]
                , p [] [ text "As a local business, we understand the unique needs of properties in the Chicago Northwest Suburbs. From harsh winters that leave salt stains to humid summers that encourage mold growth, we've seen it all and know exactly how to handle it." ]
                , p [] [ text "We're not just your pressure washing service - we're your neighbors, committed to keeping our community beautiful one property at a time." ]
                , div [ class "community-stats" ]
                    [ div [ class "stat" ]
                        [ span [ class "stat-number" ] [ text "500+" ]
                        , span [ class "stat-label" ] [ text "Properties Cleaned" ]
                        ]
                    , div [ class "stat" ]
                        [ span [ class "stat-number" ] [ text "100%" ]
                        , span [ class "stat-label" ] [ text "Satisfaction Rate" ]
                        ]
                    , div [ class "stat" ]
                        [ span [ class "stat-number" ] [ text "5★" ]
                        , span [ class "stat-label" ] [ text "Average Rating" ]
                        ]
                    ]
                ]
            , div [ class "community-image" ]
                [ img [ src "/house.jpeg", alt "Beautiful home after K&D pressure washing service" ] []
                ]
            ]
        ]


valueCard : String -> String -> String -> Html msg
valueCard icon title description =
    div [ class "value-card" ]
        [ div [ class "value-icon" ] [ text icon ]
        , h3 [] [ text title ]
        , p [] [ text description ]
        ]
