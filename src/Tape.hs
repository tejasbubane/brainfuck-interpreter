module Tape where

import Source

-- Left - Pivot - Right
data Tape a =
  Tape [a] a [a]
  deriving (Eq, Show)

emptyTape :: Tape Int
emptyTape = Tape zeros 0 zeros
  where zeros = repeat 0

moveRight :: Tape a -> Tape a
moveRight tape@(Tape ls x []) = tape
moveRight (Tape ls x (r:rs)) = Tape (x:ls) r rs

moveLeft :: Tape a -> Tape a
moveLeft tape@(Tape [] x rs) = tape
moveLeft (Tape (l:ls) x rs) = Tape ls l (x:rs)

advance :: Tape a -> Tape a
advance = moveRight

applyF :: (a -> a) -> Tape a -> Tape a
applyF f (Tape ls x rs) = Tape ls (f x) rs

incr :: Num a => Tape a -> Tape a
incr = applyF (+ 1)

decr :: Num a => Tape a -> Tape a
decr = applyF (subtract 1)

instance Functor Tape where
  fmap f (Tape ls x rs) = Tape (fmap f ls) (f x) (fmap f rs)

tapeFromList :: [a] -> Tape a
tapeFromList (b:bs) = Tape [] b bs
