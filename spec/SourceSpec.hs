module SourceSpec where

import Test.Hspec
import Test.QuickCheck
import Source

exceptCommands :: Char -> Char
exceptCommands c = if elem c "><+-.,[]" then ' ' else c

instance Arbitrary Command where
  arbitrary = do
    c <- exceptCommands <$> arbitrary
    oneof [return GoRight,
           return GoLeft,
           return Increment,
           return Decrement,
           return Print,
           return Read,
           return LoopL,
           return LoopR,
           return (Comment c)]

specs :: SpecWith ()
specs = describe "Source" $ do
  describe "bfSource" $ do
    it "parses `[-]`" $ do
      bfSource "[-]" `shouldBe` [LoopL, Decrement, LoopR]
    it "parses `>+++-+`" $ do
      bfSource ">+++-+" `shouldBe`
        [GoRight, Increment, Increment, Increment, Decrement, Increment]
    it "is inverse of toString" $ property $ do
      \x -> (toString . bfSource) x == (x :: String)

  describe "toString" $ do
    it "converts to string" $ do
      toString [LoopL, Decrement, LoopR] `shouldBe` "[-]"
      toString [GoRight, Increment, Increment, Increment, Decrement, Increment]
        `shouldBe` ">+++-+"
    it "is inverse of bfSource" $ property $ do
      \x -> (bfSource . toString) x == (x :: BFSource)
