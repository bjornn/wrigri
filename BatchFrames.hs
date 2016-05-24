module BatchFrames where
import Data.ConfigFile
import Data.Either.Utils
import qualified Data.ByteString.Char8 as B
import qualified SimpleCSV as SC

data ReadFrame = ReadFrame {
      formatColIndex :: Int
    , keyColIndex :: Int
    , valueColIndex :: Int
    , firstValueColIndex :: Int
    , fileNameRowIndex :: Int
    , outputFolderNameRowIndex :: Int
    } deriving Show

data FrameDoc = FrameDoc ReadFrame B.ByteString B.ByteString deriving Show
    
makeReadFrame :: FilePath -> IO ReadFrame
makeReadFrame configFilePath = do
    config <- readfile emptyCP configFilePath
    let
        cp = forceEither config
        keyColIndex = (forceEither $ get cp "Interactive" "keycolindex") :: Int
        formatColIndex = (forceEither $ get cp "Interactive" "formatcolindex") :: Int
        firstValueColIndex = (forceEither $ get cp "Batch" "batch_firstdoccol") :: Int
        fileNameRowIndex = (forceEither $ get cp "Batch" "batch_outputdocnamesrow") :: Int
        outputFolderNameRow = (forceEither $ get cp "Batch" "batch_outputdirrow") :: Int
    return (ReadFrame formatColIndex keyColIndex firstValueColIndex firstValueColIndex fileNameRowIndex outputFolderNameRow)
    
pullColCfg content formatColIndex keyColIndex contentColIndex =
    let
        pcontents = SC.parseCSV content
    in
        B.unlines $ map (\(a, b, c) -> B.append (B.append (B.snoc a ';') (B.snoc b ';')) c) $ zip3 (SC.getCol pcontents formatColIndex) (SC.getCol pcontents keyColIndex) (SC.getCol pcontents contentColIndex)

--applyReadFrame :: ReadFrame -> B.ByteString ->
applyReadFrame (ReadFrame formatColIndex keyColIndex valueColIndex firstValueColIndex fileNameRowIndex outputFolderNameRowIndex) contents =
  pullColCfg contents formatColIndex keyColIndex valueColIndex
  
nextFrame :: FrameDoc -> FrameDoc
nextFrame (FrameDoc (ReadFrame a b valueColIndex d e f) csvData _) =
  let nextReadFrame = ReadFrame a b (valueColIndex + 1) d f f in
  FrameDoc nextReadFrame csvData (applyReadFrame nextReadFrame csvData)

-- Pull the current frame doc  
pullFrameDoc :: FrameDoc -> B.ByteString
pullFrameDoc (FrameDoc _ _ result) = result

pullCSVData :: FrameDoc -> B.ByteString
pullCSVData (FrameDoc _ csvData _) = csvData

-- Pull out all docs
pullFrames :: FrameDoc  -> [B.ByteString] -> [B.ByteString]
pullFrames (FrameDoc (ReadFrame a b valueColIndex d e f) csvData currentDoc) result =
  let
    lastColIndex =  getLastColIndex csvData
  in
    if valueColIndex < lastColIndex
    then pullFrames (nextFrame (FrameDoc (ReadFrame a b valueColIndex d e f) csvData currentDoc)) (result ++ [currentDoc])
    else result


getLastColIndex :: B.ByteString -> Int
getLastColIndex csvContent =
  length $ ((map (B.split ';') . B.lines) csvContent) !! 0 


makeFilePath :: FrameDoc -> FilePath
makeFilePath (FrameDoc (ReadFrame a b c d filenameRow folderpathRow) csvContent currentDoc) =
    let
        filename = (!! filenameRow) $ B.unlines currentDoc
        folderPath = (!! folderpathRow) $ B.unlines currentDoc
    in
      folderPath ++ "/" ++ filename ++ ".out"

-- The getFrameAndContent function parses the files and initializes the required data for further process. 
-- Use in combination with pullFrames to get a list of documents ready for formatting.
getFrameAndContent :: FilePath -> FilePath -> IO FrameDoc  
getFrameAndContent configFileName contentFileName = do
  readFrame <- makeReadFrame configFileName
  csvData  <- B.readFile contentFileName
  return (FrameDoc readFrame csvData (applyReadFrame readFrame csvData))
