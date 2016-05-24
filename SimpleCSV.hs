module SimpleCSV where
import qualified Data.ByteString.Char8 as B
import Data.ByteString.Char8 (ByteString)
type Field = ByteString
type Row = [Field]
type CSV = [Row]
type Col = [Field]


getLastColIndex :: ByteString -> Int
getLastColIndex csvContent =
  length $ ((map (B.split ';') . B.lines) csvContent) !! 0 
  

parseCSV :: ByteString -> CSV
parseCSV string = (map (B.split ';') . B.lines) string

getCol :: CSV -> Int -> Col
getCol csv colindex = (map (\x -> x !! colindex) csv)

getRow :: CSV -> Int -> Row
getRow csv rowIndex =
    csv !! rowIndex

pullThreeCols :: ByteString -> Int -> Int -> Int -> ByteString
pullThreeCols content colIndexA colIndexB colIndexC =
    let
        pcontents = parseCSV content
    in
        B.unlines $ map (\(a, b, c) -> B.append (B.append (B.snoc a ';') (B.snoc b ';')) c) $ zip3 (getCol pcontents colIndexA) (getCol pcontents colIndexB) (getCol pcontents colIndexC)




pullCol content colIndex =
    let
        pcontents = parseCSV content
    in
        B.unlines $ map (\(a, b, c) -> B.append (B.append (B.snoc a ';') (B.snoc b ';')) c) $ zip3 (getCol pcontents 0) (getCol pcontents 4) (getCol pcontents colIndex)

pullFileCol :: FilePath -> Int -> IO ()
pullFileCol filename colIndex = do
    contents <- B.readFile filename
    print $ pullCol contents colIndex

parseCSVFile :: FilePath -> IO ()
parseCSVFile filename = do
    contents <- B.readFile filename
    print $ parseCSV contents


test1 :: IO ( )
test1 = do
    contents <- B.readFile "workbook_test.csv"
    print $ pullCol contents 2

testGetRow :: IO ( )
testGetRow  = do
    contents <- B.readFile  "workbook_test.csv"
    print $ show (getRow (parseCSV contents) 1)
