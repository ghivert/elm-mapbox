module Mapbox.Endpoint
    exposing
        ( Endpoint
        , Maps
        , toUrl
        , maps
        , streets
        , light
        , dark
        , satellite
        , streetsSatellite
        , wheatpaste
        , streetsBasic
        , comic
        , outdoors
        , runBikeHike
        , pencil
        , pirates
        , emerald
        , highContrast
        )

{-| Endpoint module construct correct endpoints to Mapbox, and provide predefined endpoints as well as custom endpoints. It ensures that Maps endpoints are correctly reversed in the url generation. (As indicated in Mapbox API for v4 version of Maps.)


# Types

@docs Endpoint
@docs Maps


# Url Generation

@docs toUrl


# Maps Endpoints


## Custom Endpoints

@docs maps


## Predefined Endpoints

@docs streets
@docs light
@docs dark
@docs satellite
@docs streetsSatellite
@docs wheatpaste
@docs streetsBasic
@docs comic
@docs outdoors
@docs runBikeHike
@docs pencil
@docs pirates
@docs emerald
@docs highContrast

-}


{-| Endpoint type typed according to the service used on Mapbox. They are generated using constructors.
-}
type Endpoint a
    = Endpoint
        { api : String
        , version : String
        , maps : Bool
        }


{-| Type for Maps Endpoints.
-}
type Maps
    = Maps


isV4Version : String -> Bool
isV4Version =
    (==) "v4"


isMapsApi : Endpoint a -> Bool
isMapsApi (Endpoint { maps }) =
    maps


concatEndpoint : String -> String -> String
concatEndpoint api version =
    api ++ "/" ++ version


{-| Generate string from Endpoints in the correct order to use it into Mapbox urls. You generally don't need to use it, as Mapbox.url calls it.
-}
toUrl : Endpoint a -> String
toUrl ((Endpoint { api, version }) as endpoint) =
    let
        concat =
            if isMapsApi endpoint then
                flip concatEndpoint
            else
                concatEndpoint
    in
        concat api version


mapsToUrl : Endpoint Maps -> String
mapsToUrl ((Endpoint { api, version }) as endpoint) =
    if isV4Version version then
        concatEndpoint version api
    else
        toUrl endpoint


endpoint : Bool -> String -> String -> Endpoint a
endpoint maps api version =
    Endpoint
        { api = api
        , version = version
        , maps = maps
        }



{-
   ███    ███  █████  ██████  ███████     ███████ ███    ██ ██████  ██████   ██████  ██ ███    ██ ████████ ███████
   ████  ████ ██   ██ ██   ██ ██          ██      ████   ██ ██   ██ ██   ██ ██    ██ ██ ████   ██    ██    ██
   ██ ████ ██ ███████ ██████  ███████     █████   ██ ██  ██ ██   ██ ██████  ██    ██ ██ ██ ██  ██    ██    ███████
   ██  ██  ██ ██   ██ ██           ██     ██      ██  ██ ██ ██   ██ ██      ██    ██ ██ ██  ██ ██    ██         ██
   ██      ██ ██   ██ ██      ███████     ███████ ██   ████ ██████  ██       ██████  ██ ██   ████    ██    ███████
-}


{-| Produce an `Endpoint Maps` endpoint, allowing to use custom username and id.
-}
maps : String -> String -> Endpoint Maps
maps username id =
    endpoint True (username ++ "." ++ id) "v4"


mapboxEndpoint : String -> Endpoint Maps
mapboxEndpoint =
    maps "mapbox"


{-| Provide "mapbox.streets" endpoint.
-}
streets : Endpoint Maps
streets =
    mapboxEndpoint "streets"


{-| Provide "mapbox.light" endpoint.
-}
light : Endpoint Maps
light =
    mapboxEndpoint "light"


{-| Provide "mapbox.dark" endpoint.
-}
dark : Endpoint Maps
dark =
    mapboxEndpoint "dark"


{-| Provide "mapbox.satellite" endpoint.
-}
satellite : Endpoint Maps
satellite =
    mapboxEndpoint "satellite"


{-| Provide "mapbox.streets-satellite" endpoint.
-}
streetsSatellite : Endpoint Maps
streetsSatellite =
    mapboxEndpoint "streets-satellite"


{-| Provide "mapbox.wheatpaste" endpoint.
-}
wheatpaste : Endpoint Maps
wheatpaste =
    mapboxEndpoint "wheatpaste"


{-| Provide "mapbox.streets-basic" endpoint.
-}
streetsBasic : Endpoint Maps
streetsBasic =
    mapboxEndpoint "streets-basic"


{-| Provide "mapbox.comic" endpoint.
-}
comic : Endpoint Maps
comic =
    mapboxEndpoint "comic"


{-| Provide "mapbox.outdoors" endpoint.
-}
outdoors : Endpoint Maps
outdoors =
    mapboxEndpoint "outdoors"


{-| Provide "mapbox.run-bike-hike" endpoint.
-}
runBikeHike : Endpoint Maps
runBikeHike =
    mapboxEndpoint "run-bike-hike"


{-| Provide "mapbox.pencil" endpoint.
-}
pencil : Endpoint Maps
pencil =
    mapboxEndpoint "pencil"


{-| Provide "mapbox.pirates" endpoint.
-}
pirates : Endpoint Maps
pirates =
    mapboxEndpoint "pirates"


{-| Provide "mapbox.emerald" endpoint.
-}
emerald : Endpoint Maps
emerald =
    mapboxEndpoint "emerald"


{-| Provide "mapbox.high-contrast" endpoint.
-}
highContrast : Endpoint Maps
highContrast =
    mapboxEndpoint "high-contrast"
