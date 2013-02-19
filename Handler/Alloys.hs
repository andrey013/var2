{-# LANGUAGE TupleSections, OverloadedStrings, RecordWildCards #-}
module Handler.Alloys where

import Import
import SharedTypes
import Yesod.Fay
import Data.Text (unpack)
import Control.Monad (forM)

import Database.Persist.Query.Join (SelectOneMany (..), selectOneMany)
import Database.Persist.Query.Join.Sql (runJoin)

getAlloysR :: Handler RepHtml
getAlloysR = defaultLayout $ do
        let handlerName = "getHomeR" :: Text
        aDomId <- lift newIdent
        setTitle "Редактор сплавов"
        $(widgetFile "alloys")
        addScript $ StaticR js_d3_v3_min_js
        $(fayFile "Post")
        


onCommand :: CommandHandler App App
onCommand render (RollDie a r) = render r a
onCommand render (GetAlloys r) = do

    results <- runDB $ runJoin (selectOneMany (AlloyParameterAlloy <-.) alloyParameterAlloy)
        { somOrderOne = [Asc AlloyName]
        , somIncludeNoMatch = True
        }
    {-alloyIds <- runDB $ selectList [AlloyName >=. "0"] []
    alloysWithParameters <- forM alloyIds $ \alloyId -> do
        Just alloy <- get alloyId
        params <- runDB $ selectList [AlloyParameterAlloy ==. alloyId] []
        return (alloy, params)-}
    list <- mapM convert $ map (\(a,b) -> (entityVal a, map entityVal b)) results
    render r $ List list
  where
    convert (Import.Alloy{..}, ps) = do
        params <- mapM convertParam ps
        return SharedTypes.Alloy{
                   alloyName = unpack alloyName
                  ,alloyParams = params
               }
    convertParam Import.AlloyParameter{..} = do
        Just param <- runDB $ get alloyParameterParameter
        return SharedTypes.AlloyParameter1D{
                    oneDValue = alloyParameterValue
                   ,oneDName = unpack $ parameterRusName param
                   ,oneDMin = parameterMinBound param
                   ,oneDMax = parameterMaxBound param
               }
