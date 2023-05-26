module Probability where

import Data.Maybe
import Data.Tuple
import Data.Number (log, pow, round)
import Prelude

data Probability
    = Proba Number
    | Odds Number Number
    | Evidence Number

data Conversion
    = AsProba
    | AsOdds
    | AsEvidence

logBase :: Number -> Number -> Number
logBase base num = log num / log base


convert :: Conversion -> Probability -> Probability
convert to from =
    case Tuple from to of
      Tuple (Proba _) AsProba -> from
      Tuple (Odds _ _) AsOdds -> from
      Tuple (Evidence _) AsEvidence -> from
      Tuple (Proba p) AsOdds -> Odds (p / (1.0 - p)) 1.0
      Tuple (Odds for against) AsProba -> Proba $ for / (for + against)
      Tuple (Odds for against) AsEvidence -> Evidence $ round $ (*) 10.0 $ logBase 10.0 $ for / against
      Tuple (Evidence e) AsOdds -> Odds (pow 10.0 (e / 10.0)) 1.0
      Tuple (Proba _) AsEvidence ->
            from
                # convert AsOdds
                # convert AsEvidence
      Tuple (Evidence _) AsProba ->
            from
                # convert AsOdds
                # convert AsProba
