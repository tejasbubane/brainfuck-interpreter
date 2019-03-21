module Main where

import Interpreter
import System.Environment (getArgs)

main :: IO ()
main = do
  [f] <- getArgs
  source <- readFile f
  process dataTape (sourceTape source)
