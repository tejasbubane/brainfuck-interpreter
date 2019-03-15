module Tape where

-- Left - Pivot - Right
data Tape a =
  Tape [a] a [a]
  deriving (Eq, Show)

emptyTape :: Tape Int
emptyTape = Tape zeros 0 zeros
  where zeros = repeat 0

moveRight :: Tape a -> Tape a
moveRight (Tape ls x (r:rs)) = Tape (x:ls) r rs

moveLeft :: Tape a -> Tape a
moveLeft (Tape (l:ls) x rs) = Tape ls l (x:rs)

instance Functor Tape where
  fmap f (Tape ls x rs) = Tape (fmap f ls) (f x) (fmap f rs)
