module Main exposing (..)

import Html
import Mapbox.Maps.SlippyMap as Mapbox
import Mapbox.Endpoint as Endpoint
import Env exposing (mapboxToken)


main : Program Never number msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : ( number, Cmd msg )
init =
    0 ! []


update : a -> b -> ( number, Cmd msg )
update msg model =
    0 ! []


view : a -> Html.Html msg
view model =
    Mapbox.slippyMap Endpoint.streets mapboxToken.private Nothing Nothing (Mapbox.Size 1000 1000)
