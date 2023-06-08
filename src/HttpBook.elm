-- Wir definieren ein Elm-Modul namens "HttpBook", welches alle Funktionen und Typen offen legt.
module HttpBook exposing (..)

-- Importieren von benötigten Modulen: "Browser", "Html" und "Http".
import Browser
import Html exposing (Html, text, pre)
import Http

-- Die Hauptfunktion der Anwendung, sie definiert das Verhalten der Anwendung.
main =
  Browser.element
    { init = init -- Die init-Funktion wird beim Start der Anwendung ausgeführt und gibt das anfängliche Modell und eventuelle Befehle zurück.
    , update = update -- Die update-Funktion wird aufgerufen, wenn Nachrichten (Msg) auftreten. Sie nimmt die aktuelle Nachricht und das aktuelle Modell und gibt das neue Modell und eventuelle neue Befehle zurück.
    , subscriptions = subscriptions -- Die subscriptions-Funktion gibt zurück, welche "Subscriptions" (Hintergrundaufgaben) das Programm hat.
    , view = view -- Die view-Funktion gibt die HTML-Ausgabe der Anwendung basierend auf dem aktuellen Modell zurück.
    }

-- Modelldefinition, das den aktuellen Zustand der Anwendung darstellt. Es kann "Failure", "Loading" oder "Success" sein.
type Model
  = Failure
  | Loading
  | Success String

-- Die init-Funktion initialisiert das Modell auf "Loading" und gibt einen Befehl zurück, um eine HTTP-Anfrage zu starten.
init : () -> (Model, Cmd Msg) -- nimmt keine Eingabe -> dargestellt durch die leere Klammer
init _ =
  ( Loading
  , Http.get
      { url = "https://elm-lang.org/assets/public-opinion.txt" -- Die URL, von der die Daten abgerufen werden sollen.
      , expect = Http.expectString GotText -- Die Antwort wird als String erwartet und in eine "GotText"-Nachricht gewandelt.
      }
  )

-- Typdefinition für die möglichen Nachrichten (Msg), die in der Anwendung auftreten können. Im Moment gibt es nur eine: "GotText".
type Msg
  = GotText (Result Http.Error String)

-- Die update-Funktion nimmt die aktuelle Nachricht und das aktuelle Modell und gibt das neue Modell und eventuelle neue Befehle zurück.
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotText result ->
      case result of
        Ok fullText -> -- Im Falle eines erfolgreichen HTTP-Aufrufs wird das Modell auf "Success" gesetzt und der Text der Antwort zurückgegeben.
          (Success fullText, Cmd.none)

        Err _ -> -- Im Falle eines Fehlers beim HTTP-Aufruf wird das Modell auf "Failure" gesetzt.
          (Failure, Cmd.none)

-- In dieser Anwendung gibt es keine Subscriptions, daher gibt diese Funktion immer "Sub.none" zurück.
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- Die view-Funktion gibt das aktuelle Modell als HTML zurück.
view : Model -> Html Msg
view model =
  case model of
    Failure -> -- Im Falle eines Fehlers wird eine Fehlermeldung angezeigt.
      text "I was unable to load your book."

    Loading -> -- Während das Modell auf "Loading" steht, wird eine Ladeanzeige angezeigt.
      text "Loading..."

    Success fullText -> pre [] [ text fullText ]      -- Im Falle eines erfolgreichen HTTP-A
    
     