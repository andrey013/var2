{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
module SharedTypes where

import "fay-base" Prelude
import "fay-base" Data.Data
--import Language.Fay.Prelude
import Language.Fay.Yesod
import Language.Fay.FFI ()

data Command = RollDie (Returns Int)
    deriving (Show, Read, Typeable, Data)
