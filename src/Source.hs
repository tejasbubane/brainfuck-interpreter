module Source (Command(..), BFSource, bfSource, toString) where

data Command =
  GoRight     -- >
  | GoLeft    -- <
  | Increment -- +
  | Decrement -- -
  | Print     -- .
  | Read      -- ,
  | LoopL     -- [
  | LoopR     -- ]
  | Comment Char -- anything else
  deriving (Show, Eq)

charToBF :: Char -> Command
charToBF '>' = GoRight
charToBF '<' = GoLeft
charToBF '+' = Increment
charToBF '-' = Decrement
charToBF '.' = Print
charToBF ',' = Read
charToBF '[' = LoopL
charToBF ']' = LoopR
charToBF c = Comment c

bfToChar :: Command -> Char
bfToChar GoRight = '>'
bfToChar GoLeft = '<'
bfToChar Increment = '+'
bfToChar Decrement = '-'
bfToChar Print = '.'
bfToChar Read = ','
bfToChar LoopL = '['
bfToChar LoopR = ']'
bfToChar (Comment c) = c

type BFSource = [Command]

bfSource :: String -> BFSource
bfSource = map charToBF

toString :: BFSource -> String
toString = map bfToChar
