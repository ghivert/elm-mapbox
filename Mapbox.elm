module Mapbox exposing (url)

{-| Description
@docs url
-}

import Mapbox.Endpoint as Endpoint exposing (Endpoint)
import Helpers


{-| -}
url : Endpoint a -> String -> String -> String -> List ( String, String ) -> String
url endpoint accessToken options format parameter =
    "https://api.mapbox.com/" ++ Endpoint.toUrl endpoint ++ options ++ format ++ "?access_token=" ++ accessToken ++ parametersToUrl parameter


parameterToUrl : ( String, String ) -> String
parameterToUrl ( name, value ) =
    name ++ "=" ++ value


parametersToUrl : List ( String, String ) -> String
parametersToUrl =
    List.map parameterToUrl
        >> String.join "&"
        >> Helpers.addBeginningAmpersand
