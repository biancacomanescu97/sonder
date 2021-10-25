module Main exposing (Model, Msg(..), Styles, init, main, styles, subscriptions, update, view)

import Animation exposing (px)
import Browser
import Html exposing (Html, div, button, img, video, a, text)
import Html.Attributes exposing (style, src, href, target)
import Html.Events exposing (onClick)

type alias Model =
    { style : Animation.State }

type Msg
    = Show
    | Hide
    | Animate Animation.Msg

type alias Styles =
    { open : List Animation.Property
    , closed : List Animation.Property
    }

styles : Styles
styles =
    { closed =
        [ Animation.right (px 0.0)
        , Animation.top (px 0.0)
        , Animation.opacity 1.0
        ]
    , open =
        [ Animation.right (px -320.0)
        , Animation.top (px 40.0)
        , Animation.opacity 0.6
        ]
    }

main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

init : ( Model, Cmd Msg )
init =
    ( { style = Animation.style styles.closed }
    , Cmd.none
    )

view : Model -> Html Msg
view model =
    div [ style "position" "fixed"
        , style "width" "100%"
        , style "height" "100%"
        , style "background-color" "black"
        ]
        [ div [ style "position" "relative"
              , style "width" "100%"
              , style "height" "100%"
              ] 
              [ menu ]
        , div
            (Animation.render model.style
                ++ [ style "position" "absolute"
                   , style "width" "100%"
                   , style "height" "100%"
                   , style "background-color" "white"
                   , style "color" "black"
                   ]
            )
            [ div [ style "position" "relative" 
                  , style "width" "max-content"
                  , style "margin-top" "40px"
                  , style "margin-left" "45px" 
                  , style "z-index" "1"
                  ] 
                  [ button [ onClick Show
                           , style "padding" "5px"
                           , style "background-color" "black"
                           , style "border" "none"
                           , style "border-radius" "3px"
                           ]   
                           [ img [ src "/assets/images/menu.png"
                                 , style "width" "27px"
                                 , style "height" "27px" 
                                 ] [ ] 
                           ]
                    ]
            , div [ onClick Hide
                  , style "position" "absolute"
                  , style "width" "100%"
                  , style "height" "100%"  
                  , style "top" "0"
                  , style "right" "0"
                  ] 
                  [ container ]
            ]
        ]

update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Show ->
            ( { model
                | style =
                    Animation.interrupt
                        [ Animation.to styles.open
                        ]
                        model.style
              }
            , Cmd.none
            )

        Hide ->
            ( { model
                | style =
                    Animation.interrupt
                        [ Animation.to styles.closed
                        ]
                        model.style
              }
            , Cmd.none
            )

        Animate animMsg ->
            ( { model
                | style = Animation.update animMsg model.style
              }
            , Cmd.none
            )

subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model.style ]

menu : Html Msg
menu =
    div [ style "width" "320px"
        , style "height" "100%"
        , style "background-color" "black"
        ]
        [ div [ style "width" "320px"
              , style "height" "100%"
              , style "padding" "40px"
              ] 
              [ div [ ]
                    [ img [ src "/assets/images/Portrait.jpg"
                          , style "width" "75%"
                          , style "height" "75%" 
                          , style "padding-bottom" "20px"
                          ] [ ]
                    , div [ ] 
                          [ instaSection
                          , linkedinSection
                          , githubSection
                          ]
                    ]
               ]
        ]
    
instaSection : Html Msg
instaSection = 
    div [ style "padding" "30px"
        , style "display" "inline"
        ]
        [ a [ href "https://www.instagram.com/bianca.coms", target "_blank"]
            [ img [ src "/assets/images/instagram.png"
                  , style "width" "20px"
                  , style "height" "20px" 
                  ] [ ]
            ] 
        ]

linkedinSection : Html Msg
linkedinSection = 
    div [ style "padding" "30px"
        , style "display" "inline"
        ]
        [ a [ href "https://www.linkedin.com/in/bianca-comanescu/", target "_blank" ]
            [ img [ src "/assets/images/linkedin.png"
                  , style "width" "20px"
                  , style "height" "20px" 
                  ] [ ]
            ] 
        ]

githubSection : Html Msg
githubSection = 
    div [ style "padding" "30px"
        , style "display" "inline"
        ]
        [ a [ href "https://github.com/biancacomanescu97", target "_blank" ]
            [ img [ src "/assets/images/github.png"
                  , style "width" "22px"
                  , style "height" "22px" 
                  ] [ ]
            ] 
        ]

container : Html Msg
container = 
    div [ style "height" "100%"
        , style "margin-top" "120px"
        , style "margin-left" "127px"
        , style "margin-right" "127px"
        ] 
        [ yoga ]

yoga : Html Msg
yoga = 
    div [ style "width" "100%"
        , style "height" "80%" 
        , style "display" "flex"
        ] 
        [ video [ src "/assets/videos/Yoga.mp4"
                , style "width" "420px" 
                , style "max-width" "100%"
                , style "height" "auto"
                ] [ ]
        , div [ style "position" "relative"
              , style "padding-top" "40px"
              , style "padding-left" "40px" 
              ]
              [ div [ style "font-family" "Lucida Console, Courier, monospace" 
                    , style "font-size" "40px"
                    , style "display" "block"
                    ] 
                    [ text "LILT" ] 
              , div [ style "font-family" "Lucida Console, Courier, monospace" 
                    , style "font-size" "20px"
                    , style "text-align" "justify"
                    , style "padding-top" "40px"
                    ] 
                    [ text """The system presents a self-teaching software which allows the user to perfect their
                        movements. The aim of this project is to compute the similarity between two poses, 
                        one captured by the web-camera and one chosen by the user.""" ]    
              , a [ href "https://github.com/biancacomanescu97/lilt", target "_blank" ] 
                    [ button [ style "font-family" "Lucida Console, Courier, monospace" 
                           , style "font-size" "20px"
                           , style "position" "absolute"
                           , style "right" "0"
                           , style "bottom" "0"
                           , style "background-color" "black"
                           , style "color" "white"
                           , style "border" "none"
                           , style "border-radius" "3px"
                           , style "padding" "8px"
                           ] 
                           [ text "Try it out!"]   
                    ]
                  
              ]
        ]