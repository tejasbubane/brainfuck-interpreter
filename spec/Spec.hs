import Test.Hspec
import BrainFuck
import qualified SourceSpec

main :: IO ()
main = hspec $ do
  SourceSpec.specs
