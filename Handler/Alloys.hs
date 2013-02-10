{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Alloys where

import Import
import SharedTypes
import Yesod.Fay

getAlloysR :: Handler RepHtml
getAlloysR = defaultLayout $ do
        let handlerName = "getHomeR" :: Text
        aDomId <- lift newIdent
        setTitle "Alloys0"
        $(widgetFile "alloys")
        -- $(fayFile "Post")
        


onCommand :: CommandHandler App App
onCommand render command =
    case command of
        RollDie r -> do
            render r 4
