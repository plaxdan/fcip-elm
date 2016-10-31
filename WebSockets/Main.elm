module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket


main =
    App.program
        { init = init
        , view = view
        , update =
            \msg model ->
                update (Debug.log "Msg" msg) (Debug.log "Model" model)
        , subscriptions = subscriptions
        }


echoServer : String
echoServer =
    "wss://echo.websocket.org"



-- MODEL


type alias Model =
    { input : String
    , messages : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )



-- UPDATE


type Msg
    = Input String
    | Send
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newInput ->
            ( { model | input = newInput }, Cmd.none )

        Send ->
            ( { model | input = "" }, WebSocket.send echoServer model.input )

        NewMessage str ->
            ( { model | messages = str :: model.messages }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen echoServer NewMessage



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput Input, value model.input ] []
        , button [ onClick Send ] [ text "Send" ]
        , model.messages
            |> List.reverse
            |> List.map viewMessage
            |> div []
        ]


viewMessage : String -> Html msg
viewMessage msg =
    div [] [ text msg ]
