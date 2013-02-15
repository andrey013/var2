{-# LANGUAGE NoImplicitPrelude #-}
module Post where

import Prelude
import FFI
import Language.Fay.Yesod
import Language.Fay.D3
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
            -> (Automatic a -> Fay ()) -- ^ Success Handler
            -> Fay ()
ajaxCommand = ffi "jQuery['ajax']({ url: window['yesodFayCommandPath'], type: 'POST', data: { json: JSON.stringify(%1) }, dataType: 'json', success : %2})"

data Event = Event{
    getY :: Int
}

main :: Fay ()
main = do
    call (GetAlloys) $ \ (List d) -> do
        print $ d
        table <- (select "#alloys" >>= append "table")
        thead <- append "thead" table
        tbody <- append "tbody" table
        let columns = ["Название", "Ликвидус", "Солидус"]
        append "tr" thead >>=
            selectAll "th" >>=
            d3data columns >>=
            enter >>=
            append' "th" >>=
            textWith id
        rows <- selectAll "tr" tbody >>=
            d3data d >>=
            enter >>=
            append' "tr"
        cells <- selectAll' "td" rows >>=
            d3dataWith (\row -> [alloyName row, show $ alloyLiquidus row, show $ alloySolidus row]) >>=
            enter >>=
            append' "td"-- >>=
            --textWith (\a -> a)
        svg <- append' "svg" cells >>=
            attr' "width" 30 >>=
            attr' "height" 100 >>=
            append' "g"
        drag <- d3behaviorDrag >>=
            origin id >>=
            --on "dragstart" (d3this) >>= --(this.parentNode.appendChild(this))
            on' "drag" (\d ->
                d3this >>= select' >>= attrS "transform" ("translate(5," ++ show (getY d) ++ ")")) --(dragmove)
        node <- append' "g" svg >>=
            attrS' "class" "node" >>=
            attrS' "transform" "translate(5,50)" >>=
            d3call drag
        slider <- append' "rect" node >>=
            attr' "width" 20 >>=
            attr' "height" 8
        return ()

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
