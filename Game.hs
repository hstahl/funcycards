{-
 - A game of poker includes the players and a deck of cards.
 - The players are dealt 5 cards each from the deck after which
 - they give up 0-5 cards in exchange for new ones. Finally,
 - the player's hands are pitted against each other and a winner
 - is decided.
 -}
module Game (
  Game(..),
  newGame,
  discardThese,
  pickThese,
  takeNFromDeck,
  takeLFromDeck,
  giveWinner
) where

import Data.List (sortBy)
import Card
import Deck
import PokerHand
import Player

type Game = ([Player],Deck)

newGame :: [Player] -> Deck -> Game
newGame xs ys = (xs,ys)

{-
 - Discards the cards in the list from the player's hands.
 - See: discardCards in Player
 -}
discardThese :: Game -> [[Card]] -> Game
discardThese g [] = g
discardThese g xs = let players = [newhand i | i <- [1..length (fst g)]]
                        newhand i = discardCards (xs !! i) (fst g !! i)
                    in  (players,snd g)

{-
 - Adds the cards in the list to the player's hands. The cards
 - should be taken from the game deck.
 - See: pickCards in Player
 -}
pickThese :: Game -> [[Card]] -> Game
pickThese g [] = g
pickThese g xs = let players = [newhand i | i <- [1..length (fst g)]]
                     newhand i = pickCards (xs !! i) (fst g !! i)
                 in  (players,snd g)

{-
 - Takes n cards from the game deck and returns the new
 - game state (with n cards missing from deck) along with
 - the cards in a tuple.
 - See: takeCard in Deck
 -}
takeNFromDeck :: Game -> Int -> (Game,[Card])
takeNFromDeck g n
    | n <= 0    = (g,[])
    | otherwise = let deck = snd g
                      (newcard,newdeck) = takeCard deck
                      newgame = (fst g,newdeck)
                      next = takeNFromDeck newgame (n-1)
                  in  (fst next,newcard:snd next)

{-
 - Takes a list of integers and takes their sum
 - amount of cards from the game deck, returning the
 - new game state and a list of a list of the cards
 - with each list containing as many cards as the
 - corresponding integers. Meant to be used with
 - pickThese.
 -}
takeLFromDeck :: Game -> [Int] -> (Game,[[Card]])
takeLFromDeck g [] = (g,[])
takeLFromDeck g xi = let n = head xi
                         (newgame,cards) = takeNFromDeck g n
                         next = takeLFromDeck newgame (tail xi)
                     in  (fst next, snd next ++ [cards])

{-
 - Returns the player who has the best hand.
 -}
giveWinner :: [Player] -> Player
giveWinner = head . sortBy (\a b -> hand a `compareHands` hand b)
