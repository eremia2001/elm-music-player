-- Importieren von Modulen, die benötigt werden
module Main exposing (..)
import Browser
import Html exposing (Html, button, div, text, Attribute, input)
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)
import Dict exposing (update)


-- Hauptfunktion
main =
  Browser.sandbox { init = init, update = update, view = view }


-- Model 

type alias Model =
    { content : String
    }

-- Initialisieren des Modells
init : Model
init = {content = ""}


-- Update 
type Msg = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
       Change newContent -> {model |content = newContent}

view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
    , div [] [ text (String.reverse model.content) ], div[][text (String.fromInt <| String.length model.content)]]