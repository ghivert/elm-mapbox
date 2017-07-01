module Mapbox.Maps.Tiles
    exposing
        ( Coordinates
        , Format(..)
        , ImageFormat(..)
        , tiles
        , GeoCoordinates
        , Parameters
        , features
        )

{-| Description
@docs Coordinates
@docs Format
@docs ImageFormat
@docs tiles
@docs GeoCoordinates
@docs Parameters
@docs features
-}

import Mapbox
import Mapbox.Endpoint exposing (Endpoint, Maps)
import Helpers
import GeoJson exposing (GeoJson)
import Http


{-| -}
type alias Coordinates =
    { x : Int
    , y : Int
    , z : Int
    }


{-| -}
type Format
    = UtfGrid
    | Vector
    | Image ImageFormat


{-| -}
type ImageFormat
    = Png
    | Png32
    | Png64
    | Png128
    | Png256
    | Jpg70
    | Jpg80
    | Jpg90


coordinatesToOptions : Coordinates -> String
coordinatesToOptions { x, y, z } =
    [ z, x, y ]
        |> List.map toString
        |> String.join "/"
        |> Helpers.addBeginningSlash


formatToUrl : Format -> String
formatToUrl format =
    case format of
        UtfGrid ->
            ".grid.json"

        Vector ->
            ".mvt"

        Image imageFormat ->
            imageFormatToUrl imageFormat


imageFormatToUrl : ImageFormat -> String
imageFormatToUrl imageFormat =
    case imageFormat of
        Png ->
            ".png"

        Png32 ->
            ".png32"

        Png64 ->
            ".png64"

        Png128 ->
            ".png128"

        Png256 ->
            ".png256"

        Jpg70 ->
            ".jpg70"

        Jpg80 ->
            ".jpg80"

        Jpg90 ->
            ".jpg90"


{-| -}
tiles : Endpoint Maps -> String -> Coordinates -> Bool -> Format -> String
tiles endpoint accessToken coordinates retina format =
    Mapbox.url endpoint accessToken (coordinatesToOptions coordinates ++ Helpers.retinaToUrl retina) (formatToUrl format) []


{-| -}
type alias GeoCoordinates =
    { longitude : Float
    , latitude : Float
    }


{-| -}
type alias Parameters =
    { radius : Maybe Int
    , limit : Maybe Int
    }


geoCoordinatesToUrl : GeoCoordinates -> String
geoCoordinatesToUrl { longitude, latitude } =
    [ longitude, latitude ]
        |> List.map toString
        |> String.join ","
        |> Helpers.addBeginningSlash


parametersToUrl : Parameters -> List ( String, String )
parametersToUrl { radius, limit } =
    List.concat
        [ parameterToList "radius" radius
        , parameterToList "limit" limit
        ]


parameterToList : String -> Maybe a -> List ( String, String )
parameterToList name =
    Maybe.map (parameterTuple name >> List.singleton)
        >> Maybe.withDefault []


parameterTuple : String -> a -> ( String, String )
parameterTuple name value =
    ( name, toString value )


{-| -}
features : Endpoint Maps -> String -> GeoCoordinates -> Parameters -> Http.Request GeoJson
features endpoint accessToken coordinates parameters =
    Http.get (Mapbox.url endpoint accessToken ("/tilequery" ++ geoCoordinatesToUrl coordinates) ".json" (parametersToUrl parameters)) GeoJson.decoder
