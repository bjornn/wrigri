{-# LANGUAGE ScopedTypeVariables #-}
module WriteInAGrid where
-- This is the parsing functionality which reads format-key-value triplets from a csv file.

import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Char8 as B
import System.Environment
import Data.Csv 
import Data.Char
import qualified Data.Vector as V
import GHC.Word
import qualified SimpleCSV as SC
import qualified FormatFunctions as FF

-- Consider lifting the delimiter-option to the configuration --
myOptions = defaultDecodeOptions {
      decDelimiter =  fromIntegral (ord ';')
    }


convert :: (String -> String -> String -> String) -> B.ByteString -> Int -> String
convert convFn contents colIndex =
    let
        csvc =  BL.fromStrict $ SC.pullCol contents colIndex
    in
    case decodeWith myOptions NoHeader csvc of
        Left err -> err
        Right v -> V.forM_ v $ \ (inst :: String, key :: String, v1 :: String) ->
            putStrLn (FF.html inst key v1)
            --(convFn inst key v1)
