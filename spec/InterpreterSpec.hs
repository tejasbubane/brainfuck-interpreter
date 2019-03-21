module InterpreterSpec where

import Test.Hspec
import Test.QuickCheck
import System.IO.Silently
import Interpreter

specs :: SpecWith ()
specs = describe "Interpreter" $ do
  it "runs Hello World!" $ do
    source <- readFile "spec/support/hello.bf"
    (captured, result) <- capture (process dataTape (sourceTape source))
    captured `shouldBe` "Hello World!\n"
  it "prints 7" $ do
    source <- readFile "spec/support/seven.bf"
    (captured, result) <- capture (process dataTape (sourceTape source))
    captured `shouldBe` "7"
