module TapeSpec where

import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Tape

instance Arbitrary a => Arbitrary (Tape a) where
  arbitrary = do
    ls <- arbitrary
    pivot <- arbitrary
    rs <- arbitrary
    return $ Tape ls pivot rs

instance Eq a => EqProp (Tape a) where
  (=-=) = eq

specs :: SpecWith ()
specs = describe "Tape" $ do
  describe "moveRight" $ do
    it "moves pivot to right" $ do
      moveRight (Tape [0] 1 [0]) `shouldBe` Tape [1,0] 0 []
      moveRight (Tape [0,1,2] 3 [4,5,6]) `shouldBe` Tape [3,0,1,2] 4 [5,6]
  describe "moveLeft" $ do
    it "moves pivot to left" $ do
      moveLeft (Tape [0] 1 [0]) `shouldBe` Tape [] 0 [1,0]
      moveLeft (Tape [0,1,2] 3 [4,5,6]) `shouldBe` Tape [1,2] 0 [3,4,5,6]

  let tapeTrigger = undefined :: Tape (Int, Double, Char)
  it "has well-defined functor instance" $ property $ do
    quickBatch $ functor tapeTrigger
