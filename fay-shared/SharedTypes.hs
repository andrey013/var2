{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
module SharedTypes where

import Prelude
import Data.Data
--import Language.Fay.Prelude
import Language.Fay.Yesod
--import Fay.FFI ()

data Alloy = Alloy {
    alloyName       :: String
   ,alloyParams :: [AlloyParameter]
} deriving (Show, Read, Typeable, Data)

data AlloyParameter =   AlloyParameter1D {
                            oneDName  :: String
                           ,oneDMin   :: Double
                           ,oneDMax   :: Double
                           ,oneDValue :: Double
                        }
                    |   AlloyParameter2D {
                            twoDName    :: String
                           ,twoDArgName :: String
                           ,twoDMin     :: Double
                           ,twoDMax     :: Double
                           ,twoDValues  :: [Point]
                        }
  deriving (Show, Read, Typeable, Data)

data Point = Point {
    pointX :: Maybe Double
   ,pointY :: Double
} deriving (Show, Read, Typeable, Data)

data List a = List{
    list :: [a]
} deriving (Show, Read, Typeable, Data)

data Command = RollDie Int (Returns Int)
             | GetAlloys (Returns (List Alloy))
    deriving (Show, Read, Typeable, Data)

