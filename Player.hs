{-
 - A player in a poker game has a name (probably)
 - and the hand of cards she is holding. Anything
 - else she has, she doesn't need.
 -}
module Player (
  Player(..),
  discardCards,
  pickCards
) where

import PokerHand
import Card

data Player = Player {name :: String, hand :: Hand} deriving (Show)

{-
 - Returns a player without the cards in the list in her hand.
 -}
discardCards :: [Card] -> Player -> Player
discardCards [] p = p
discardCards xs p = let newHand = filter (`notElem` xs) . cards . hand $ p
                    in  Player (name p) (Hand newHand)

{-
 - Adds the cards in the list to the player's hand
 -}
pickCards :: [Card] -> Player -> Player
pickCards [] p = p
pickCards xs p = Player (name p) $ Hand (cards (hand p) ++ xs)
