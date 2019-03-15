import Test.Hspec
import BrainFuck
import qualified SourceSpec
import qualified TapeSpec

main :: IO ()
main = hspec $ do
  SourceSpec.specs
  TapeSpec.specs
