{--

Wrigri is the main module (the entry point) for command line operations of Write in a grid.

It requires one configuration file and one document file with column orientated semicolon-separated data.

Upon launch, output is produced in the output folder defined in the document file. 
The format to be produced can be controlled by the configuration file (batch_outputformats).

--}

module Wrigri where
import qualified WriteInAGrid as WG
import qualified FormatFunctions as FF


--convertIO :: convert :: (String -> String -> String -> String) -> fileName -> Int -> IO ()
--convertIO convFn filename colIndex = do
--    csvData <- B.readFile filename
--    convert convFn csvData colIndex

main :: IO ()
main = do
    [configFilename, docFilename ] <- getArgs
    
    
    case conversion of
        "markdown" -> WG.convert (FF.md) filename (read colIndex :: Int)
        "html" -> WG.convert (FF.html) filename (read colIndex :: Int)
        otherwise -> putStrLn ("Error: Unexpected output function in first command line argument. Got '" ++ conversion ++ "'. Want [markdown|html]. Halting.")
