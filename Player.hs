{-
 - A player in a poker game has a name (probably)
 - and the hand of cards she is holding. Anything
 - else she has, she doesn't need.
 -}
module Player (
  Player(..)
) where

import qualified PokerHand

data Player = Player {name :: String, hand :: PokerHand.Hand} deriving (Show)