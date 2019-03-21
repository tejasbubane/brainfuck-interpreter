import Test.Hspec
import qualified SourceSpec
import qualified TapeSpec
import qualified InterpreterSpec

main :: IO ()
main = hspec $ do
  SourceSpec.specs
  TapeSpec.specs
  InterpreterSpec.specs
