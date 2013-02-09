{-# LANGUAGE NoImplicitPrelude #-}
module Post where

import Language.Fay.Prelude
import Language.Fay.JQuery
import Language.Fay.DOM
import Language.Fay.FFI
import Language.Fay.Yesod

import SharedTypes

onUpdate :: EventObject -> Fay Bool
onUpdate e = do
    t <- eventSource e
    file <- parent t >>= childrenMatching "input[type=date]" >>= getVal
    newname <- getVal t
    call RollDie $ const $ return ()
    return True

main :: Fay ()
main = ready $ do
    onUpdate
    return ()
