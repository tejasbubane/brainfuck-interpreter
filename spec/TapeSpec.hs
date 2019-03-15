module TapeSpec where

import Test.Hspec
import Tape

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
