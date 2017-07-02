# Mapbox

Elm Mapbox aims to provide an easy way to interact with [Mapbox](https://www.mapbox.com/) web API.
Using this package allows to embed a map into a webpage or retrieve tiles informations.

## Usage
### Predefined functions
In its more simple form, all you have to do is to use predefined functions with correct parameters, i.e. you Mapbox `access_token` and the correct enpoint.

```elm
import Mapbox.Maps.SlippyMap as Mapbox
import Mapbox.Endpoint as Endpoint

mapboxToken : String
mapboxToken =
    "pk.eyJ1IjoiZ2hpdmVydCIsImEiOiJjajRqbzFlcWYwajVzMzNzZTdpZXU3MTRnIn0.wSGB3LCr5OcvPqQ61BqYyg"

-- Embed a slippy map into your website and set Options, Hash and Size of the iframe.
embeddedSlippyMap : Html msg
embeddedSlippyMap =
    Mapbox.slippyMap Endpoint.streets mapboxToken Nothing Nothing (Mapbox.Size 1000 1000)
```

`Tiles` and `EditorProject` are returning `Http.Requests GeoJson`. `GeoJson` is a specific Json format representing geographical coordinates and data. It is defined in the package [`mgold/elm-geojson`](https://github.com/mgold/elm-geojson), and you can find additional informations on [geojson.org](http://geojson.org/) or the [RFC7946](https://tools.ietf.org/html/rfc7946) specification.

### Constructing your own requests

You may prefer to construct your own request directly to Mapbox. To do it, use `Mapbox.url` the different arguments are constructing urls based on the Mapbox schema, i.e. `https://api.mapbox.com/{endpoint}{options}{format}?access_token={accessToken}{parameters}`. Obviously, you should preferably use predefined functions, guaranting type checking and providing HTML embedding or HTTP Requests.
