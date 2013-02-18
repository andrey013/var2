{-# LANGUAGE TupleSections, OverloadedStrings, RecordWildCards #-}
module Handler.Alloys where

import Import
import SharedTypes
import Yesod.Fay
import Data.Text (unpack)

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
    alloys <- runDB $ selectList [AlloyName >=. "0"] []
    render r $ List $ map (convert . entityVal) alloys
  where
    convert Import.Alloy{..} = SharedTypes.Alloy{
                                   alloyName = unpack alloyName
                                  ,alloyParameters = []
                               }
