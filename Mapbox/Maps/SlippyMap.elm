module Mapbox.Maps.SlippyMap exposing (Options, Position, Size, slippyMap)

{-| Allows to embed a slippy map directly into your Html view.

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


{-| Options you can use into slippy maps.
-}
type alias Options =
    { zoomwheel : Bool
    , zoompan : Bool
    , geocoder : Bool
    , share : Bool
    }


{-| Initial position you can set into slippy maps.
-}
type alias Position =
    { zoom : Int
    , latitude : Int
    , longitude : Int
    }


{-| Size of the iframe.
-}
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


{-| Embed a slippy map into your Html view. As indicated in the Readme, you can easily use it like this:

    import Mapbox.Maps.SlippyMap as Mapbox
    import Mapbox.Endpoint as Endpoint

    mapboxToken : String
    mapboxToken =
        "pk.eyJ1IjoiZ2hpdmVydCIsImEiOiJjajRqbzFlcWYwajVzMzNzZTdpZXU3MTRnIn0.wSGB3LCr5OcvPqQ61BqYyg"


    -- Embed a slippy map into your website and set Options, Hash and Size of the iframe.

    embeddedSlippyMap : Html msg
    embeddedSlippyMap =
        Mapbox.slippyMap Endpoint.streets mapboxToken Nothing Nothing (Mapbox.Size 1000 1000)

-}
slippyMap :
    Endpoint Maps
    -> String
    -> Maybe Options
    -> Maybe Position
    -> Size
    -> Html msg
slippyMap endpoint accessToken options position { width, height } =
    Html.iframe
        [ Html.Attributes.src (Mapbox.url endpoint accessToken (optionsToUrl options) (".html" ++ positionToUrl position) [])
        , Html.Attributes.width width
        , Html.Attributes.height height
        ]
        []
