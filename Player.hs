{-
 - A player in a poker game has a name (probably)
 - and the hand of cards she is holding. Anything
 - else she has, she doesn't need.
 -}
module Player (
  Player(..)
) where

import PokerHand
import Card

data Player = Player {name :: String, hand :: Hand} deriving (Show)

{-
 - Returns a player without the cards in the list in her hand.
 -}
discardCards :: [Card] -> Player -> Player
discardCards [] p = p
discardCards xs p = let newHand = [x | x <- hand p, not $ x `elem` xs]
                    in  Player (name p) newHand

{-
 - Adds the cards in the list to the player's hand
 -}
pickCards :: [Card] -> Player -> Player
pickCards [] p = p
pickCards xs p = Player (name p) (hand p ++ xs)
