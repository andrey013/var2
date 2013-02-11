{-# LANGUAGE NoImplicitPrelude #-}
module Post where

import Prelude
import FFI
import Language.Fay.Yesod
import SharedTypes

alert' :: (Returns a -> command) -> Fay ()
alert' f = alert'' (f Returns)

alert'' :: Automatic c -> Fay ()
alert'' = ffi "window.alert(%1)"

alert :: String -> Fay ()
alert = ffi "window.alert(%1)"

-- | Call a command.
call :: (Returns a -> command)
     -> (a -> Fay ()) -- ^ Success Handler
     -> Fay ()
call f g = ajaxCommand (f Returns) g

-- | Run the AJAX command.
ajaxCommand :: Automatic command
            -> (a -> Fay ()) -- ^ Success Handler
            -> Fay ()
ajaxCommand = ffi "jQuery['ajax']({ url: window['yesodFayCommandPath'], type: 'POST', data: { json: JSON.stringify(%1) }, dataType: 'json', success : %2})"

main :: Fay ()
main = call (GetAlloys) $ (alert . show)
