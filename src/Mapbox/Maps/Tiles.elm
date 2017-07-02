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

{-| Allows to access tiles API. The tiles are returned as image from Mapbox. As there is no notion of image into elm today, they only return the correct url to use it according to what you want to do.


# Tiles

@docs Coordinates
@docs Format
@docs ImageFormat
@docs tiles


# Features Tiles

@docs GeoCoordinates
@docs Parameters
@docs features

-}

import Mapbox
import Mapbox.Endpoint exposing (Endpoint, Maps)
import Helpers
import GeoJson exposing (GeoJson)
import Http


{-| Coordinates required by tiles API, in form of x, y and z.
-}
type alias Coordinates =
    { x : Int
    , y : Int
    , z : Int
    }


{-| Format in which you want your tile.
-}
type Format
    = UtfGrid
    | Vector
    | Image ImageFormat


{-| Image format in which you wan your tile.
-}
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


{-| Returns an url to Mapbox, retrieving a tile from the site. It can be either an UTFGrid, a vector, or an image. You can probably extract the data from UTFGrid directly in elm, but you probably need to use JS to retrieve vectors or images.
-}
tiles : Endpoint Maps -> String -> Coordinates -> Bool -> Format -> String
tiles endpoint accessToken coordinates retina format =
    Mapbox.url endpoint accessToken (coordinatesToOptions coordinates ++ Helpers.retinaToUrl retina) (formatToUrl format) []


{-| Geographical coordinates.
-}
type alias GeoCoordinates =
    { longitude : Float
    , latitude : Float
    }


{-| Parameters accepted by the features tiles requests.
-}
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


{-| Retrieve a FeatureCollection from tiles. It returns an `Http.Request GeoJson`, in the format you can have in [`mgold/elm-geojson`](https://github.com/mgold/elm-geojson).
-}
features : Endpoint Maps -> String -> GeoCoordinates -> Parameters -> Http.Request GeoJson
features endpoint accessToken coordinates parameters =
    Http.get (Mapbox.url endpoint accessToken ("/tilequery" ++ geoCoordinatesToUrl coordinates) ".json" (parametersToUrl parameters)) GeoJson.decoder
