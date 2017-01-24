module Main exposing (..)

import Html exposing (div, button, text)
import Html.Events exposing (onClick)


pluralize singular plural quantity =
    if quantity == 1 then
        singular
    else
        plural


displayText model =
    pluralize "goose" "geese" model


main =
    Html.beginnerProgram { model = 1, view = view, update = update }


view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (displayText model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1
