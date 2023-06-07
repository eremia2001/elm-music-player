module PasswortAuth exposing (..)

-- Importieren von Modulen, die benötigt werden
import Browser
import Html exposing (Html, button, div, text, Attribute, input)
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)
import Dict exposing (update)
import Char exposing (isUpper)


-- Hauptfunktion
main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }


-- Model 
type alias Model =
    { name : String,
      password : String,
      passwordAgain : String
    }

init : Model
init = {name = "" , password = "" , passwordAgain = ""}

type Msg
    = Name String | Password String | PasswordAgain String



update : Msg -> Model -> Model
update msg model =
    case msg of
        Name newName  -> {model | name = newName}
        Password newPassword -> {model | password = newPassword}
        PasswordAgain newPasswordAgain -> {model | passwordAgain = newPasswordAgain}
            

view : Model -> Html Msg
view model =
  div [][
    viewInput "text" "Name" model.name Name,
    viewInput "password" "Password" model.password Password,
    viewInput "passwrd" "Password Again" model.passwordAgain PasswordAgain,
    viewValidation model
  ]
   

viewInput : String -> String -> String -> (String -> msg ) -> Html msg
viewInput inputType inputPlaceHolder inputValue toMsg = 
  input[type_ inputType ,placeholder inputPlaceHolder ,value inputValue, onInput toMsg ][]

viewValidation : Model -> Html Msg
viewValidation model = 
  if model.password /= model.passwordAgain  then 
    div [style "color" "red"][text "Password not matching  "]
  else if not (String.length  model.password  >= 8) then
      div [style "color" "red"][text "Password too short !  "]
  else if not (String.any isUpper model.password) then
      div [style "color" "red"][text "Password must contain Upper Char "]
  else 
        div [style "color" "red"][text "OK  "]



