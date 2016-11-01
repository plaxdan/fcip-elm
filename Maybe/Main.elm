module Main exposing (..)

import Html exposing (text)
import List


type alias Name =
    { first : String
    , middle : Maybe String
    , last : String
    }


names =
    [ "Alice", "Bob", "Eve" ]


fetchFirst list =
    List.head list


main =
    text "Let's talk about Maybe"
