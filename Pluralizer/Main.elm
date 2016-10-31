module Main exposing (..)

import Html exposing (div, button, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)


pluralize singular plural quantity =
    if quantity == 1 then
        singular
    else
        plural


displayText model =
    pluralize "goose" "geese" model


main =
    beginnerProgram
        { model = 1
        , view = view
        , update = update
        }


view model =
    div []
        [ button [ onClick "decrement" ] [ text "-" ]
        , div [] [ text (displayText model) ]
        , button [ onClick "increment" ] [ text "+" ]
        ]


update msg model =
    if msg == "increment" then
        model + 1
    else if msg == "decrement" then
        model - 1
    else
        model
