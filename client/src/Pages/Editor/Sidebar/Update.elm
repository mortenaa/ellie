module Pages.Editor.Sidebar.Update exposing (..)

import Data.Ellie.ApiError as ApiError exposing (ApiError)
import Data.Elm.Package as Package exposing (Package)
import Data.Elm.Package.Version as Version exposing (Version)
import Ellie.Api as Api
import Pages.Editor.Sidebar.Model as Model exposing (Model)


type Msg
    = SearchChanged String
    | ResultsLoaded (Result ApiError (List Package))
    | ChangePanel Model.Panel


update : Version -> Msg -> Model -> ( Model, Cmd Msg )
update version msg model =
    case msg of
        SearchChanged search ->
            if String.length search > 1 then
                ( { model | search = search }
                , Api.searchPackages version search
                    |> Api.send ResultsLoaded
                )
            else
                ( { model | search = search, results = [] }
                , Cmd.none
                )

        ResultsLoaded result ->
            ( { model | results = Result.withDefault [] result }
            , Cmd.none
            )

        ChangePanel panel ->
            ( { model
                | panel =
                    if Just panel == model.panel then
                        Nothing
                    else
                        Just panel
              }
            , Cmd.none
            )
