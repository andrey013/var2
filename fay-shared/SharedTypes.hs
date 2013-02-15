{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
module SharedTypes where

import Prelude
import Data.Data
--import Language.Fay.Prelude
import Language.Fay.Yesod
--import Fay.FFI ()

data Alloy = Alloy {
    alloyName     :: String
   ,alloyLiquidus :: Double
   ,alloySolidus  :: Double
} deriving (Show, Read, Typeable, Data)

data List a = List{
    list :: [a]
} deriving (Show, Read, Typeable, Data)

data Command = RollDie Int (Returns Int)
             | GetAlloys (Returns (List Alloy))
    deriving (Show, Read, Typeable, Data)

