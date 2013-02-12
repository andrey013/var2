{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
module SharedTypes where

import Prelude
import Data.Data
--import Language.Fay.Prelude
import Language.Fay.Yesod
--import Fay.FFI ()

data Alloy = Alloy {
    name     :: String
   ,liquidus :: Double
   ,solidus  :: Double
} deriving (Show, Read, Typeable, Data)

data Command = RollDie Int (Returns Int)
             | GetAlloys (Returns [Alloy])
    deriving (Show, Read, Typeable, Data)

