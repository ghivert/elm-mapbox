module Helpers exposing (addBeginningSlash, addBeginningAmpersand, retinaToUrl)


addBeginningString : String -> String -> String
addBeginningString before string =
    if String.isEmpty string then
        ""
    else
        before ++ string


addBeginningSlash : String -> String
addBeginningSlash =
    addBeginningString "/"


addBeginningAmpersand : String -> String
addBeginningAmpersand =
    addBeginningString "&"


retinaToUrl : Bool -> String
retinaToUrl retina =
    if retina then
        "@2x"
    else
        ""
