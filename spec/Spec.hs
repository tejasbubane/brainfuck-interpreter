import Test.Hspec
import qualified BrainFuck as BF

main :: IO ()
main = hspec $ do
  describe "Parsing" $ do
    it "works" $ do
      2 `shouldBe` 2
