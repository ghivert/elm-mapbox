module Mapbox.Maps.SlippyMap exposing (Options, Position, Size, slippyMap)

{-| Description
@docs Options
@docs Position
@docs Size
@docs slippyMap
-}

import Mapbox
import Mapbox.Endpoint as Endpoint exposing (Endpoint, Maps)
import Html exposing (Html)
import Html.Attributes
import Helpers


{-| -}
type alias Options =
    { zoomwheel : Bool
    , zoompan : Bool
    , geocoder : Bool
    , share : Bool
    }


{-| -}
type alias Position =
    { zoom : Int
    , latitude : Int
    , longitude : Int
    }


{-| -}
type alias Size =
    { width : Int
    , height : Int
    }


removeOption : ( String, Bool ) -> List String
removeOption ( option, presence ) =
    if presence then
        [ option ]
    else
        []


optionsToUrl : Maybe Options -> String
optionsToUrl options =
    case options of
        Nothing ->
            ""

        Just { zoompan, zoomwheel, geocoder, share } ->
            [ ( "zoompan", zoompan )
            , ( "zoomwheel", zoomwheel )
            , ( "geocoder", geocoder )
            , ( "share", share )
            ]
                |> List.concatMap removeOption
                |> String.join ","
                |> Helpers.addBeginningSlash


positionToUrl : Maybe Position -> String
positionToUrl position =
    case position of
        Nothing ->
            ""

        Just { zoom, latitude, longitude } ->
            [ zoom, latitude, longitude ]
                |> List.map toString
                |> String.join "/"
                |> (++) "#"


{-| -}
slippyMap : Endpoint Maps -> String -> Maybe Options -> Maybe Position -> Size -> Html msg
slippyMap endpoint accessToken options position { width, height } =
    Html.iframe
        [ Html.Attributes.src (Mapbox.url endpoint accessToken (optionsToUrl options) (".html" ++ positionToUrl position) [])
        , Html.Attributes.width width
        , Html.Attributes.height height
        ]
        []
