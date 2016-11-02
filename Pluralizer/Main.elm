module Main exposing (..)

import Html exposing (div, button, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)


type Msg
    = Increment
    | Decrement
    | Double


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
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (displayText model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Double ] [ text "double" ]
        , text ("model is " ++ (toString model))
        ]


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Double ->
            model * 2
