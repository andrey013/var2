{-# LANGUAGE NoImplicitPrelude #-}
module Post where

import Prelude hiding (min, max)
import FFI
import Language.Fay.Yesod
import Language.Fay.D3
import SharedTypes


min :: Automatic a -> Automatic a -> a
min = ffi "Math.min(%1,%2)"

max :: Automatic a -> Automatic a -> a
max = ffi "Math.max(%1,%2)"

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
            -> (Automatic a -> Fay ()) -- ^ Success Handler
            -> Fay ()
ajaxCommand = ffi "jQuery['ajax']({ url: window['yesodFayCommandPath'], type: 'POST', data: { json: JSON.stringify(%1) }, dataType: 'json', success : %2})"

{-
dragstart :: Fay D3
dragstart = ffi "this.parentNode.appendChild(this)"

echothis :: Fay D3
echothis = ffi "(function () { this.console.log(this); }).call()"
-}

data CellContent = TextCell String
                 | DoubleCell Double

main :: Fay ()
main = do
    call (GetAlloys) $ \ (List d) -> do
        print $ d
        table <- (select "#alloys" >>= append "table")
        --thead <- append "thead" table
        tbody <- append "tbody" table
        let columns = ["Название", "Ликвидус", "Солидус"]
        {-append "tr" thead >>=
            selectAll "th" >>=
            d3data columns >>=
            enter >>=
            append' "th" >>=
            textWith id-}
        rows <- selectAll "tr" tbody >>=
            d3data d >>=
            enter >>=
            append' "tr"
        cells <- selectAll' "td" rows >>=
            d3dataWith (\row -> [TextCell $ alloyName row]) >>=
            enter >>=
            append' "td"-- >>=
            --textWith (\a -> a)
        textFields <-
            (filterWith (\d -> case d of TextCell _ -> True; _ -> False) cells) >>=
            textWith (\(TextCell s) -> s)
        doubleFields <-
            (filterWith (\d -> case d of DoubleCell _ -> True; _ -> False) cells)
        svg <- append' "svg" doubleFields >>=
            attr' "width" 80 >>=
            attr' "height" 100 >>=
            append' "g"
        dragg' <- drag
        node <- append' "g" svg >>=
            attrS' "class" "node" >>=
            attrWith "transform" (\(DoubleCell d) -> "translate(5," ++ show (100 - ((d-1500) / 2)) ++ ")") >>=
            d3call dragg'
        slider <- append' "rect" node >>=
            attr' "width" 20 >>=
            attr' "height" 8 >>=
            attr' "rx" 2 >>=
            attr' "ry" 2
        textNode <- append' "text" node >>=
            attr' "x" 21 >>=
            attr' "y" 4 >>=
            attrS' "dy" ".35em" >>=
            textWith (\(DoubleCell d) -> show d)
        return ()
  where
    drag :: Fay (D3D CellContent)
    drag = d3behaviorDrag >>=
        origin >>=
        --on "dragstart" (\this -> do parentNode this >>= appendChild this) >>= --(this.parentNode.appendChild(this))
        on' "drag" (\this (DoubleCell d) -> do
            --print d; print this
            y <- parentNode this >>= d3mouse
            e <- d3event
            print e
            let minY = max 0 $ min 100 (y !! 1)
            let value = (100-minY)*2+1500
            --print minY
            select' this >>= attrS "transform" ("translate(5," ++ show (min 92 minY) ++ ")") >>=
                selectAll "text" >>= text (show value)
        )

{-
function tabulate(data, columns) {
    var table = d3.select("#container").append("table"),
        thead = table.append("thead"),
        tbody = table.append("tbody");

    // append the header row
    thead.append("tr")
        .selectAll("th")
        .data(columns)
        .enter()
        .append("th")
            .text(function(column) { return column; });

    // create a row for each object in the data
    var rows = tbody.selectAll("tr")
        .data(data)
        .enter()
        .append("tr");

    // create a cell in each row for each column
    var cells = rows.selectAll("td")
        .data(function(row) {
            return columns.map(function(column) {
                return {column: column, value: row[column]};
            });
        })
        .enter()
        .append("td")
            .text(function(d) { return d.value; });
    
    return table;
}

// create some people
var people = [
    {name: "Jill", age: 30},
    {name: "Bob", age: 32},
    {name: "George", age: 29},
    {name: "Sally", age: 31}
];

// render the table
var peopleTable = tabulate(people, ["name", "age"]);

// uppercase the column headers
peopleTable.selectAll("thead th")
    .text(function(column) {
        return column.charAt(0).toUpperCase() + column.substr(1);
    });
    
// sort by age
peopleTable.selectAll("tbody tr")
    .sort(function(a, b) {
        return d3.descending(a.age, b.age);
    });
-}
