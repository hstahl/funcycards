{-
 - This file is a part of the funcycards project.
 -
 - PokerHand is a 5-card hand in a poker game. This module
 - enables comparing hands to determine a winner.
 -}
module PokerHand (
  Hand(..),
  HandCateg(..),
  compareHands,
  evaluateHand
) where

import Data.List
import qualified Card

type Hand = [Card.Card]

{-
 - The winning categories of poker hands
 -}
data HandCateg = HighCard
               | Pair
               | TwoPair
               | ThreeOfAKind
               | Straight
               | Flush
               | FullHouse
               | FourOfAKind
               | StraightFlush
               | RoyalFlush
               deriving (Eq, Ord, Bounded, Enum, Show, Read)

{-
 - Does a "deep" compare of two hands by checking the
 - categories first and, if they are equal, looks at face values.
 -}
compareHands :: Hand -> Hand -> Ordering
compareHands [] [] = EQ
compareHands xs [] = GT
compareHands [] ys = LT
compareHands xs ys
    | evaluateHand xs /= evaluateHand ys = (evaluateHand xs) `compare` (evaluateHand ys)
    | otherwise = case evaluateHand xs
                  of   HighCard      -> compareHighCards xs ys
                       Pair          -> compareNOfKind 2 xs ys
                       TwoPair       -> compareNOfKind 2 xs ys
                       ThreeOfAKind  -> compareNOfKind 3 xs ys
                       Straight      -> compareHighCards xs ys
                       Flush         -> compareHighCards xs ys
                       FullHouse     -> compareFullHouse xs ys
                       FourOfAKind   -> compareNOfKind 4 xs ys
                       StraightFlush -> compareHighCards xs ys
                       RoyalFlush    -> EQ

compareHighCards :: Hand -> Hand -> Ordering
compareHighCards [] [] = EQ
compareHighCards xs [] = GT
compareHighCards [] ys = LT
compareHighCards xs ys
    | last valx /= last valy = (last valx) `compare` (last valy)
    | otherwise              = compareHighCards (init ordx) (init ordy)
    where
        ordx = sort xs
        ordy = sort ys
        valx = values ordx
        valy = values ordy

{-
 - Compares the n-of-a-kind hands of two players. The one who has
 - n cards of the same higher face value is judged greater. If
 - both players have n cards of the same value, then the remaining
 - high cards determine the ordering. This works also for
 - comparing hands of two pairs with n=2 because a list is made
 - of the values of the pairs and then compared using
 - compareSortedValues.
 -
 - See: compareSortedValues
 -}
compareNOfKind :: Int -> Hand -> Hand -> Ordering
compareNOfKind _ [] [] = EQ
compareNOfKind _ xs [] = GT
compareNOfKind _ [] ys = LT
compareNOfKind n xs ys
    | valOfKind valx /= valOfKind valy = (valOfKind valx) `compareSortedValues` (valOfKind valy)
    | otherwise                        = (valHigh valx) `compareSortedValues` (valHigh valy)
    where
        valx = sort $ values xs
        valy = sort $ values ys
        valOfKind xs = [head x | x <- group xs, length x == n]
        valHigh xs   = [head x | x <- group xs, length x == 1]

{-
 - Two full houses are compared by looking at the values of
 - the three-of-a-kind part and, if it is equal, then the
 - pair part.
 -}
compareFullHouse :: Hand -> Hand -> Ordering
compareFullHouse [] [] = EQ
compareFullHouse xs [] = GT
compareFullHouse [] ys = LT
compareFullHouse xs ys
    | three xs /= three ys = (three xs) `compare` (three ys)
    | otherwise            = (two xs) `compare` (two ys)
    where
        three xs = [head x | x <- (group . sort . values) xs, length x == 3]
        two xs   = [head x | x <- (group . sort . values) xs, length x == 2]

{-
 - Compares two pre-sorted lists of values.
 -}
compareSortedValues :: [Card.Value] -> [Card.Value] -> Ordering
compareSortedValues [] [] = EQ
compareSortedValues xs [] = GT
compareSortedValues [] ys = LT
compareSortedValues xs ys
    | head xs == head ys = compareSortedValues (tail xs) (tail ys)
    | otherwise          = (head xs) `compare` (head ys)

{-
 - Returns the winning category of a hand. Only defined
 - for a hand of 5 cards.
 -}
evaluateHand :: Hand -> HandCateg
evaluateHand [] = error "Empty hand"
evaluateHand xs
    | isRoyal xs     = RoyalFlush
    | isStrFlush xs  = StraightFlush
    | isFourKind xs  = FourOfAKind
    | isFullHouse xs = FullHouse
    | isFlush xs     = Flush
    | isStraight xs  = Straight
    | isThreeKind xs = ThreeOfAKind
    | isTwoPair xs   = TwoPair
    | isPair xs      = Pair
    | otherwise      = HighCard
    where
        isRoyal xs     = isStrFlush xs && (maximum . values) xs == Card.Ace
        isStrFlush xs  = isFlush xs && isStraight xs
        isFourKind xs  = nOfKind 4 xs
        isFullHouse xs = let list = [length l | l <- (group . sort . values) xs]
                         in  2 `elem` list && 3 `elem` list
        isFlush (x:xs) = foldl (\acc y -> if Card.getSuit x /= y then False else acc) True $ suits xs
        isStraight [x] = True
        isStraight xs  = if length (values xs) == (length . nub . values) xs && (succ . head . sort . values) xs `elem` (values xs) then (isStraight . tail . sort ) xs else False
        isThreeKind xs = nOfKind 3 xs
        isTwoPair xs   = sort [length l | l <- (group . sort . values) xs] == [1,2,2]
        isPair xs      = nOfKind 2 xs
        nOfKind n xs   = maximum [length l | l <- (group . sort . values) xs] == n

values :: Hand -> [Card.Value]
values xs = [Card.getValue x | x <- xs]

suits :: Hand -> [Card.Suit]
suits xs = [Card.getSuit x | x <- xs]
