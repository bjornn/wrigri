module WrigriIO where

parseConfigFile :: FilePath -> ConfigData
parseConfigFile configFilePath = do
  return ("")


main :: IO ()
main = do
  [configFilePath, docFilePath ] <- getArgs
  let cf <- parseConfigFile configFilePath  
  
