module ProbabilityUI where

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Data.Number.Format (toStringWith, fixed)
import Data.Tuple (Tuple(..))
import Prelude
import Probability (Conversion(..), Probability(..), convert)

switchableProbability :: forall a. Probability -> Widget HTML Unit
switchableProbability proba = do
  void $ D.button [P.onClick] [D.text display]
  switchableProbability next
    where
      Tuple display next =
        case proba of
          Proba p -> Tuple (toStringWith (fixed 2) p <> "%") (convert AsOdds proba)
          Odds o1 o2 -> Tuple (toStringWith (fixed 0) o1 <> ":" <> toStringWith (fixed 0) o2) (convert AsEvidence proba)
          Evidence e -> Tuple (toStringWith (fixed 0) e <> "dB") (convert AsProba proba)
