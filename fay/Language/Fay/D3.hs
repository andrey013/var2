{-D3.js bindings for Fay-}
{-# LANGUAGE EmptyDataDecls    #-}
module Language.Fay.D3 (
    append,
    append',
    appendChild,
    attr,
    attrS,
    attr',
    attrS',
    attrWith,
    classed,
    classedWith,
    classedWithIndex,
    d3call,
    d3behaviorDrag,
    d3data,
    d3dataWith,
    d3event,
    d3mouse,
    d3this,
    enter,
    exit,
    filter,
    filterWith,
    filterWithIndex,
    getDY,
    html,
    htmlWith,
    htmlWithIndex,
    on,
    on',
    origin,
    parentNode,
    property,
    propertyWith,
    propertyWithIndex,
    remove,
    remove',
    select,
    select',
    selectAll,
    selectAll',
    style,
    styleWith,  
    styleWithIndex,
    text,
    textWith,
    textWithIndex,
    D3,
    D3D
    ) where

import           FFI
import           Prelude

data D3

-- | Work with data (d3.select().data([]))
data D3D a


d3call :: D3D a -> D3D a -> Fay (D3D a)
d3call = ffi "%2['call'](%1)"

d3behaviorDrag :: Fay (D3D a)
d3behaviorDrag = ffi "d3.behavior.drag()"

d3this :: Fay D3
d3this = ffi "this"

d3event :: Fay a
d3event = ffi "d3['event']"

d3mouse :: D3 -> Fay [Double]
d3mouse = ffi "d3['mouse'](%1)"

getDY :: D3 -> Fay Int
getDY = ffi "%1['sourceEvent']['y']"

origin :: (D3D a) -> Fay (D3D a)
origin = ffi "%1['origin'](function(d) { return d; })"

on :: String -> (t -> Fay D3) -> (D3D a) -> Fay (D3D a)
on = ffi "%3['on'](%1, (function() { %2(this); }))"

on' :: String -> (t -> a -> Fay D3) -> (D3D a) -> Fay (D3D a)
on' = ffi "%3['on'](%1,(function(d) { %2(this,d); }))"

parentNode :: D3 -> Fay D3
parentNode = ffi "%1['parentNode']"

appendChild :: D3 -> D3 -> Fay D3
appendChild = ffi "%2['appendChild'](%1)"

----
---- Select
----

d3filter :: String -> D3 -> Fay D3
d3filter = ffi "%2['filter'](%1)"

filterWith :: (a -> Bool) -> D3D a -> Fay (D3D a)
filterWith = ffi "%2['filter'](%1)"

filterWithIndex :: (a -> Int -> Bool) -> D3D a -> Fay (D3D a)
filterWithIndex = ffi "%2['filter'](%1)"

select :: String -> Fay D3
select = ffi "d3['select'](%1)"

select' :: D3 -> Fay D3
select' = ffi "d3['select'](%1)"

selectAll :: String -> D3 -> Fay D3
selectAll = ffi "%2['selectAll'](%1)"

selectAll' :: String ->  D3D a -> Fay (D3D a)
selectAll' = ffi "%2['selectAll'](%1)"

----
---- Manipulation API
----

append :: String -> D3 -> Fay D3
append = ffi "%2['append'](%1)"

append' :: String -> D3D a -> Fay (D3D a)
append' = ffi "%2['append'](%1)"

attr :: String -> Automatic a -> D3 -> Fay D3
attr = ffi "%3['attr'](%1,%2)"

attrS :: String -> String -> D3 -> Fay D3
attrS = ffi "%3['attr'](%1,%2)"

attr' :: String -> d -> D3D a -> Fay (D3D a)
attr' = ffi "%3['attr'](%1,%2)"

attrS' :: String -> String -> D3D a -> Fay (D3D a)
attrS' = ffi "%3['attr'](%1,%2)"

attrWith :: String -> (d -> String) -> D3D a -> Fay (D3D a)
attrWith = ffi "%3['attr'](%1,%2)"

attrWithIndex :: String -> (d -> Int -> String) -> D3D a -> Fay (D3D a)
attrWithIndex = ffi "%3['attr'](%1,%2)"

classed :: String -> Bool -> D3 -> Fay D3
classed = ffi "%3['classed'](%1,%2)"

classedWith :: String -> (a -> Bool) -> D3D a -> Fay (D3D a)
classedWith = ffi "%3['classed'](%1,%2)"

classedWithIndex :: String -> (a -> Int -> Bool) -> D3D a -> Fay (D3D a)
classedWithIndex = ffi "%3['classed'](%1,%2)"

html :: String -> D3 -> Fay D3
html = ffi "%2['html'](%1)"

htmlWith :: (a -> String) -> D3D a -> Fay (D3D a)
htmlWith = ffi "%2['html'](%1)"

htmlWithIndex :: (a -> Int -> String) -> D3D a -> Fay (D3D a)
htmlWithIndex = ffi "%2['html'](%1)"

----
---- TODO: Insert
----

property :: String -> String -> D3 -> Fay D3
property = ffi "%3['property'](%1,%2)"

propertyWith :: String -> (a -> String) -> D3D a -> Fay (D3D a)
propertyWith = ffi "%3['property'](%1,%2)"

propertyWithIndex :: String -> (a -> Int -> String) -> D3D a -> Fay (D3D a)
propertyWithIndex = ffi "%3['property'](%1,%2)"

remove :: D3 -> Fay D3
remove = ffi "%1['remove']()"

remove' :: D3D a -> Fay (D3D a)
remove' = ffi "%1['remove']()"

----
---- TODO: Sort
---- 

style :: String -> String -> D3 -> Fay D3
style = ffi "%3['style'](%1,%2)"

styleWith :: String -> (a -> String) -> D3D a -> Fay (D3D a)
styleWith = ffi "%3['style'](%1,%2)"

styleWithIndex :: String -> (a -> Int -> String) -> D3D a -> Fay (D3D a)
styleWithIndex = ffi "%3['style'](%1,%2)"

text :: String -> D3 -> Fay D3
text = ffi "%2['text'](%1)"

textWith :: (a -> String) -> D3D a -> Fay (D3D a)
textWith = ffi "%2['text'](%1)"

textWithIndex :: (a -> Int -> String) -> D3D a -> Fay (D3D a)
textWithIndex = ffi "%2['text'](%1)"

----
---- Data
----
d3data :: [a] -> D3 -> Fay (D3D a)
d3data = ffi "%2['data'](%1)"

d3dataWith :: (a -> [b]) -> D3D a -> Fay (D3D b)
d3dataWith = ffi "%2['data'](%1)"

enter :: D3D a -> Fay (D3D a)
enter = ffi "%1['enter']()"

exit :: D3D a -> Fay (D3D a)
exit = ffi "%1['exit']()"

