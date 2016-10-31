module Main exposing (..)

import Html exposing (Html, button, div, h1, text)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Lazy exposing (lazy)
import Random


type alias Model =
    { face : Int }


type Msg
    = Roll
    | NewFace Int


init : ( Model, Cmd Msg )
init =
    ( { face = 1 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace num ->
            ( { model | face = num }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.face) ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]


main =
    App.program
        { init = init
        , update =
            \msg model ->
                update (Debug.log "update msg" msg) model
        , view =
            lazy
                (\model ->
                    view (Debug.log "view model" model)
                )
        , subscriptions = \_ -> Sub.none
        }
