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

{-| Description
@docs Endpoint
@docs Maps
@docs toUrl
@docs maps
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


{-| -}
type Endpoint a
    = Endpoint
        { api : String
        , version : String
        , maps : Bool
        }


{-| -}
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


{-| -}
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


{-| -}
maps : String -> String -> Endpoint Maps
maps username id =
    endpoint True (username ++ "." ++ id) "v4"


{-| -}
streets : Endpoint Maps
streets =
    maps "mapbox" "streets"


{-| -}
light : Endpoint Maps
light =
    maps "mapbox" "light"


{-| -}
dark : Endpoint Maps
dark =
    maps "mapbox" "dark"


{-| -}
satellite : Endpoint Maps
satellite =
    maps "mapbox" "satellite"


{-| -}
streetsSatellite : Endpoint Maps
streetsSatellite =
    maps "mapbox" "streets-satellite"


{-| -}
wheatpaste : Endpoint Maps
wheatpaste =
    maps "mapbox" "wheatpaste"


{-| -}
streetsBasic : Endpoint Maps
streetsBasic =
    maps "mapbox" "streets-basic"


{-| -}
comic : Endpoint Maps
comic =
    maps "mapbox" "comic"


{-| -}
outdoors : Endpoint Maps
outdoors =
    maps "mapbox" "outdoors"


{-| -}
runBikeHike : Endpoint Maps
runBikeHike =
    maps "mapbox" "run-bike-hike"


{-| -}
pencil : Endpoint Maps
pencil =
    maps "mapbox" "pencil"


{-| -}
pirates : Endpoint Maps
pirates =
    maps "mapbox" "pirates"


{-| -}
emerald : Endpoint Maps
emerald =
    maps "mapbox" "emerald"


{-| -}
highContrast : Endpoint Maps
highContrast =
    maps "mapbox" "high-contrast"
