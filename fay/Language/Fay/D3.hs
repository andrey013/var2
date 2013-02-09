{-D3.js bindings for Fay-}
{-# LANGUAGE EmptyDataDecls    #-}
module Language.Fay.D3 (
    append,
    attr,
    classed,
    classedWith,
    classedWithIndex,
    d3data,
    enter,
    exit,
    filter,
    filterWith,
    filterWithIndex,
    html,
    htmlWith,
    htmlWithIndex,
    property,
    propertyWith,
    propertyWithIndex,
    remove,
    remove',
    select,
    selectAll,
    style,
    styleWith,  
    styleWithIndex,
    text,
    textWith,
    textWithIndex,
    D3
    ) where

import           FFI
import           Prelude

data D3
instance Foreign D3

-- | Work with data (d3.select().data([]))
data (Foreign a) => D3D a
instance (Foreign a) => Foreign (D3D a)

----
---- Select
----

d3filter :: String -> D3 -> Fay D3
d3filter = ffi "%2['filter'](%1)"

filterWith :: (Foreign a) => (a -> Bool) -> D3D a -> Fay (D3D a)
filterWith = ffi "%2['filter'](%1)"

filterWithIndex :: (Foreign a) => (a -> Int -> Bool) -> D3D a -> Fay (D3D a)
filterWithIndex = ffi "%2['filter'](%1)"

select :: String -> Fay D3
select = ffi "d3['select'](%1)"

selectAll :: String -> D3 -> Fay D3
selectAll = ffi "%2['selectAll'](%1)"

----
---- Manipulation API
----

append :: (Foreign a) => String -> D3D a -> Fay (D3D a)
append = ffi "%2['append'](%1)"

attr :: (Foreign a) => String -> a -> D3 -> Fay D3
attr = ffi "%3['attr'](%1,%2)"

attrWith :: (Foreign a) => String -> (d -> String) -> D3D a -> Fay (D3D a)
attrWith = ffi "%3['attr'](%1,%2)"

attrWithIndex :: (Foreign a) => String -> (d -> Int -> String) -> D3D a -> Fay (D3D a)
attrWithIndex = ffi "%3['attr'](%1,%2)"

classed :: String -> Bool -> D3 -> Fay D3
classed = ffi "%3['classed'](%1,%2)"

classedWith :: (Foreign a) => String -> (a -> Bool) -> D3D a -> Fay (D3D a)
classedWith = ffi "%3['classed'](%1,%2)"

classedWithIndex :: (Foreign a) => String -> (a -> Int -> Bool) -> D3D a -> Fay (D3D a)
classedWithIndex = ffi "%3['classed'](%1,%2)"

html :: String -> D3 -> Fay D3
html = ffi "%2['html'](%1)"

htmlWith :: (Foreign a) => (a -> String) -> D3D a -> Fay (D3D a)
htmlWith = ffi "%2['html'](%1)"

htmlWithIndex :: (Foreign a) => (a -> Int -> String) -> D3D a -> Fay (D3D a)
htmlWithIndex = ffi "%2['html'](%1)"

----
---- TODO: Insert
----

property :: String -> String -> D3 -> Fay D3
property = ffi "%3['property'](%1,%2)"

propertyWith :: (Foreign a) => String -> (a -> String) -> D3D a -> Fay (D3D a)
propertyWith = ffi "%3['property'](%1,%2)"

propertyWithIndex :: (Foreign a) => String -> (a -> Int -> String) -> D3D a -> Fay (D3D a)
propertyWithIndex = ffi "%3['property'](%1,%2)"

remove :: D3 -> Fay D3
remove = ffi "%1['remove']()"

remove' :: (Foreign a) => D3D a -> Fay (D3D a)
remove' = ffi "%1['remove']()"

----
---- TODO: Sort
---- 

style :: String -> String -> D3 -> Fay D3
style = ffi "%3['style'](%1,%2)"

styleWith :: (Foreign a) => String -> (a -> String) -> D3D a -> Fay (D3D a)
styleWith = ffi "%3['style'](%1,%2)"

styleWithIndex :: (Foreign a) => String -> (a -> Int -> String) -> D3D a -> Fay (D3D a)
styleWithIndex = ffi "%3['style'](%1,%2)"

text :: String -> D3 -> Fay D3
text = ffi "%2['text'](%1)"

textWith :: (Foreign a) => (a -> String) -> D3D a -> Fay (D3D a)
textWith = ffi "%2['text'](%1)"

textWithIndex :: (Foreign a) => (a -> Int -> String) -> D3D a -> Fay (D3D a)
textWithIndex = ffi "%2['text'](%1)"

----
---- Data
----
d3data :: (Foreign a) => [a] -> D3 -> Fay (D3D a)
d3data = ffi "%2['data'](%1)"

enter :: (Foreign a) => D3D a -> Fay (D3D a)
enter = ffi "%1['enter']()"

exit :: (Foreign a) => D3D a -> Fay (D3D a)
exit = ffi "%1['exit']()"

