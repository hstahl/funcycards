{-
 - This file is a part of the funcycards project.
 -
 - PokerHand is a hand in a poker game. This module
 - enables comparing hands to determine a winner.
 - Hands of arbitrary length may be compared.
 -}
module PokerHand (
  Hand(..)
) where

import Data.List
import Card

newtype Hand = Hand { cards :: [Card] }

instance Show Hand where
    show h = show $ cards h

instance Eq Hand where
    a == b = sort (cards a) == sort (cards b)

instance Ord Hand where
    compare a b = compareHands a b

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
compareHands x y
    | hx == [] && hy /= [] = GT
    | hx /= [] && hy == [] = LT
    | hx == [] && hy == [] = EQ
    | evaluateHand x /= evaluateHand y = (evaluateHand x) `compare` (evaluateHand y)
    | otherwise = case evaluateHand x
                  of   HighCard      -> compareHighCards hx hy
                       Pair          -> compareNOfKind 2 hx hy
                       TwoPair       -> compareNOfKind 2 hx hy
                       ThreeOfAKind  -> compareNOfKind 3 hx hy
                       Straight      -> compareHighCards hx hy
                       Flush         -> compareHighCards hx hy
                       FullHouse     -> compareFullHouse hx hy
                       FourOfAKind   -> compareNOfKind 4 hx hy
                       StraightFlush -> compareHighCards hx hy
                       RoyalFlush    -> EQ
    where
        hx = cards x
        hy = cards y

compareHighCards :: [Card] -> [Card] -> Ordering
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
compareNOfKind :: Int -> [Card] -> [Card] -> Ordering
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
compareFullHouse :: [Card] -> [Card] -> Ordering
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
compareSortedValues :: [Value] -> [Value] -> Ordering
compareSortedValues [] [] = EQ
compareSortedValues xs [] = GT
compareSortedValues [] ys = LT
compareSortedValues xs ys
    | head xs == head ys = compareSortedValues (tail xs) (tail ys)
    | otherwise          = (head xs) `compare` (head ys)

{-
 - Returns the winning category of a hand. Defined for arbitrarily
 - long hands. As long as the hand is at least 5 cards long, all
 - winning categories are possible. A full house is still a hand with
 - three of a kind and a pair, a straight is 5 cards with successive
 - values, and a flush is at least 5 cards with the same suit.
 -}
evaluateHand :: Hand -> HandCateg
evaluateHand x
    | isRoyal (cards x)     = RoyalFlush
    | isStrFlush (cards x)  = StraightFlush
    | isFourKind (cards x)  = FourOfAKind
    | isFullHouse (cards x) = FullHouse
    | isFlush (cards x)     = Flush
    | isStraight (cards x)  = Straight
    | isThreeKind (cards x) = ThreeOfAKind
    | isTwoPair (cards x)   = TwoPair
    | isPair (cards x)      = Pair
    | otherwise     = HighCard
    where
        isRoyal xs     = isStrFlush xs && (maximum . values) xs == Ace
        isStrFlush xs  = isFlush xs && isStraight xs
        isFourKind xs  = nOfKind 4 xs
        isFullHouse xs = let list = map length . group . sort . values $ xs
                         in  2 `elem` list && 3 `elem` list
        isFlush xs     = (maximum . map length . group . sort . suits) xs >= 5
        isStraight xs  = let vals = sort . nub . values $ xs
                         in fst $ foldl (\(result,count) x ->
                                            if count == 5 then (True,count)
                                            else if x == Ace then (result,count)
                                            else if succ x `elem` vals then (result,count+1)
                                            else (result,1)) (False,1) vals
        isThreeKind xs = nOfKind 3 xs
        isTwoPair xs   = (map length . group . filter (==2) . map length . group . sort . values) xs == [2]
        isPair xs      = nOfKind 2 xs
        nOfKind n xs   = (maximum . map length . group . sort . values) xs == n

values :: [Card] -> [Value]
values = map getValue

suits :: [Card] -> [Suit]
suits = map getSuit
