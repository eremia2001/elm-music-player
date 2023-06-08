module ChatGpt exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Http


-- MODEL

type alias Model =
    { track : Maybe Track
    , status : String
    }


type alias Track =
    { id : String
    , name : String
    }


init : Model
init =
    { track = Nothing
    , status = "Stopped"
    }


-- UPDATE

type Msg
    = Play
    | Pause
    | Next
    | Previous


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play ->
            ( { model | status = "Playing" }
            , Http.get { url = "https://api.spotify.com/v1/me/player/play", expect = Http.expectWhatever Play } 
            )

        Pause ->
            ( { model | status = "Paused" }
            , Http.get { url = "https://api.spotify.com/v1/me/player/pause", expect = Http.expectWhatever Pause }
            )

        Next ->
            ( model, Cmd.none )

        Previous ->
            ( model, Cmd.none )


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Play ] [ text "Play" ]
        , button [ onClick Pause ] [ text "Pause" ]
        , button [ onClick Next ] [ text "Next" ]
        , button [ onClick Previous ] [ text "Previous" ]
        , text model.status
        ]


-- MAIN

main =
    Browser.sandbox { init = init, update = update, view = view }
