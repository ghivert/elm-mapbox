module Mapbox.Maps.EditorProject exposing (editorProject)

{-| Allows to retrieve informations from an editor project.

@docs editorProject

-}

import Mapbox
import Mapbox.Endpoint exposing (Endpoint, Maps)
import GeoJson exposing (GeoJson)
import Http


{-| Creates an Http.Request GeoJson, retrieving informations from an editor project. The decoder is already here, and returns a GeoJson record, provided by [`mgold/elm-geojson`](https://github.com/mgold/elm-geojson).
-}
editorProject : Endpoint a -> String -> Http.Request GeoJson
editorProject endpoint accessToken =
    Http.get (Mapbox.url endpoint accessToken "/features" ".json" []) GeoJson.decoder
