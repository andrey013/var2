{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
module SharedTypes where

import Prelude
import Data.Data
--import Language.Fay.Prelude
import Language.Fay.Yesod
--import Fay.FFI ()

data Command = RollDie Int (Returns Int)
             | GetAlloys (Returns [String])
    deriving (Show, Read, Typeable, Data)

