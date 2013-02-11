module Import.Fay
    ( fayFile
    ) where

import "base" Prelude
import Yesod.Fay
import Settings.Development (development)

fayFile :: FayFile
fayFile
    | development = fayFileReload
    | otherwise   = fayFileProd
