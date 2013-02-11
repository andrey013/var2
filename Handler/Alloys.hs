{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Alloys where

import Import
import SharedTypes
import Yesod.Fay
import qualified Data.Text as T


getAlloysR :: Handler RepHtml
getAlloysR = defaultLayout $ do
        let handlerName = "getHomeR" :: Text
        aDomId <- lift newIdent
        setTitle "Alloys0"
        $(widgetFile "alloys")
        $(fayFile "Post")
        


onCommand :: CommandHandler App App
onCommand render (RollDie a r) = render r a
onCommand render (GetAlloys r) = do
    alloys <- runDB $ selectList [] []
    render r $ map (T.unpack . alloyName . entityVal) alloys
