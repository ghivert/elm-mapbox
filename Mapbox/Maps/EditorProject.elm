module Mapbox.Maps.EditorProject exposing (editorProject)

{-| Description
@docs editorProject
-}

import Mapbox
import Mapbox.Endpoint exposing (Endpoint, Maps)
import GeoJson exposing (GeoJson)
import Http


{-| -}
editorProject : Endpoint a -> String -> Http.Request GeoJson
editorProject endpoint accessToken =
    Http.get (Mapbox.url endpoint accessToken "/features" ".json" []) GeoJson.decoder
