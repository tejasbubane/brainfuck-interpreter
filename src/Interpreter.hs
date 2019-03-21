module Interpreter(sourceTape, dataTape, process) where

import Source
import Tape
import Data.Char (chr, ord)

sourceTape :: String -> Tape Command
sourceTape = tapeFromList . bfSource

dataTape :: Tape Int
dataTape = emptyTape

-- Find matching `[`
loopl :: Int -> Tape Command -> Tape Command
loopl _ tape@(Tape [] _ _) = error "No commands left"
loopl 0 tape@(Tape ls LoopL rs) = moveRight tape
loopl count tape@(Tape ls LoopL rs) = loopl (count - 1) (moveLeft tape)
loopl count tape@(Tape ls LoopR rs) = loopl (count + 1) (moveLeft tape)
loopl count tape = loopl count (moveLeft tape)

-- Find matching `]`
loopr :: Int -> Tape Command -> Tape Command
loopr _ tape@(Tape _ _ []) = error "No commands left"
loopr 0 tape@(Tape ls LoopR rs) = moveRight tape
loopr count tape@(Tape ls LoopR rs) = loopr (count - 1) (moveRight tape)
loopr count tape@(Tape ls LoopL rs) = loopr (count + 1) (moveRight tape)
loopr count tape = loopr count (moveRight tape)

printAscii :: Int -> IO ()
printAscii = putChar . chr

process :: Tape Int -> Tape Command -> IO ()
process (Tape _ x _) (Tape _ command []) =
  -- only visible IO in the last step is print, rest all can be ignored
  -- even if they change data tape, that is irrelevant now that the program is terminating
  case command of
    Print -> printAscii x
    _     -> return ()
process dtape@(Tape l x r) stape@(Tape l' command r') = do
  let nextSTape = advance stape
  case command of
    GoRight   -> process (moveRight dtape) nextSTape
    GoLeft    -> process (moveLeft dtape) nextSTape
    Increment -> process (incr dtape) nextSTape
    Decrement -> process (decr dtape) nextSTape
    Print     -> do
      printAscii x
      process dtape nextSTape
    Read      -> do
      x' <- getChar
      process (Tape l (ord x') r) nextSTape
    LoopL     -> if x == 0
                 then process dtape (loopr 0 (moveRight stape))
                 else process dtape nextSTape
    LoopR     -> if x /= 0
                 then process dtape (loopl 0 (moveLeft stape))
                 else process dtape nextSTape
    Comment _ -> process dtape nextSTape
