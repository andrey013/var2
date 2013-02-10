-- NOTE: This file is auto-generated.
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE NoImplicitPrelude  #-}
{-# LANGUAGE PackageImports  #-}
-- | Module to be shared between server and client.
--
-- This module must be valid for both GHC and Fay.
module Language.Fay.Yesod where

import           Language.Fay.FFI
import           "fay-base" Prelude
import           "fay-base" Data.Data

-- | A proxy type for specifying what type a command should return. The final
-- field for each data constructor in a command datatype should be @Returns@.
data Returns a = Returns
    deriving (Show, Read, Data, Typeable)

-- | Call a command.
call :: (Returns a -> command)
     -> (a -> Fay ()) -- ^ Success Handler
     -> Fay ()
call f g = ajaxCommand (f Returns) g

-- ! Call a command, handling errors as well
callWithErrorHandling :: (Returns a -> command)
     -> (a -> Fay ()) -- ^ Success Handler
     -> (Fay ())      -- ^ Failure Handler
     -> Fay ()
callWithErrorHandling f g h = ajaxCommandWithErrorHandling (f Returns) g h

-- | Run the AJAX command.
ajaxCommand :: command
            -> (a -> Fay ()) -- ^ Success Handler
            -> Fay ()
ajaxCommand = ffi "jQuery['ajax']({ url: window['yesodFayCommandPath'], type: 'POST', data: { json: JSON.stringify(%1) }, dataType: 'json', success : %2})"

-- | Run the AJAX command, handling errors as well
ajaxCommandWithErrorHandling :: command
            -> (a -> Fay ()) -- ^ Success Handler
            -> (Fay ())      -- ^ Failure Handler
            -> Fay ()
ajaxCommandWithErrorHandling = ffi "jQuery['ajax']({ url: window['yesodFayCommandPath'], type: 'POST', data: { json: JSON.stringify(%1) }, dataType: 'json', success : %2, error: %3})"

