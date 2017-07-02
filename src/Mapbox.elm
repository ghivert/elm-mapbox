module Mapbox exposing (url)

{-| Generic module to build Mapbox urls. You can use it to construct your own urls to Mapbox, if you need something not provided in the package.
Generally, you don't need to use it. If you need to do it, please open an issue or provide a Pull Request to include new API into the package.

@docs url

-}

import Mapbox.Endpoint as Endpoint exposing (Endpoint)
import Helpers


{-| Construct your own url to Mapbox, by warranting correct `endpoints`, `access_token`, and assuming that your options and format are correct. They must have beginning `/`, and parameters is List of assoc, associating name and value of the parameter, i.e. `(name, value)`

As described in the Readme, `url` constructs urls based on schema `https://api.mapbox.com/{endpoint}{options}{format}?access_token={accessToken}{parameters}`

-}
url : Endpoint a -> String -> String -> String -> List ( String, String ) -> String
url endpoint accessToken options format parameters =
    "https://api.mapbox.com/" ++ Endpoint.toUrl endpoint ++ options ++ format ++ "?access_token=" ++ accessToken ++ parametersToUrl parameters


parameterToUrl : ( String, String ) -> String
parameterToUrl ( name, value ) =
    name ++ "=" ++ value


parametersToUrl : List ( String, String ) -> String
parametersToUrl =
    List.map parameterToUrl
        >> String.join "&"
        >> Helpers.addBeginningAmpersand
