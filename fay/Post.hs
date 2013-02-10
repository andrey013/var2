{-# LANGUAGE NoImplicitPrelude #-}
module Post where

import Language.Fay.Prelude
--import Language.Fay.JQuery
--import Language.Fay.DOM
--import FFI
import Language.Fay.Yesod

import SharedTypes
{-
alert :: String -> Fay ()
alert = ffi "window.alert(%1)"


alert' :: (Foreign a) => a -> Fay ()
alert' = ffi "window.alert(JSON.stringify(%1))"
-}
main :: Fay ()
main = print $ RollDie --call RollDie $ const $ return () -- $ (alert . show) >> return False
