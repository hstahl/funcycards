module Deck (
  Deck(..),
  newDeck,
  shuffle,
  takeCard
) where

import Card
import System.Random

type Deck = [Card]

{-
- Returns a full deck of cards as a list
-}
newDeck :: Deck
newDeck = [(x, y) | x <- [minBound..maxBound], y <- [minBound..maxBound]]

{-
- Uses a random generator to return a random permutation of [a]
-}
shuffle :: StdGen -> Deck -> Deck
shuffle _ [] = []
shuffle gen xs = let (n,newGen) = randomR (0, length xs - 1) gen
                     front = xs !! n
                 in  front : shuffle newGen (take n xs ++ drop (n + 1) xs)

{-
- Takes a deck and returns the card on top and the remaining deck as a tuple
-}
takeCard :: Deck -> (Card,Deck)
takeCard [] = error "Can't take a card from an empty deck!"
takeCard (x:xs) = (x,xs)