module PokerHand (
  Hand(..),
  HandCateg(..),
  evaluateHand,
  highCardValue
) where

import Data.List
import Card

type Hand = [Card]

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

evaluateHand :: Hand -> HandCateg
evaluateHand [] = error "Empty hand"
evaluateHand xs
    | isRoyal xs      = RoyalFlush
    | isStrFlush xs   = StraightFlush
    | isFourKind xs   = FourOfAKind
    | isFullHouse xs  = FullHouse
    | isFlush xs      = Flush
    | isStraight xs   = Straight
    | isThreeKind xs  = ThreeOfAKind
    | isTwoPair xs    = TwoPair
    | isPair xs       = Pair
    | otherwise       = HighCard
    where
        isRoyal xs     = isStrFlush xs && ((maximum (values xs)) == Ace)
        isStrFlush xs  = isFlush xs && isStraight xs
        isFourKind xs  = xOfKind 4 xs
        isFullHouse xs = let list = [length l | l <- group (sort (values xs))]
                         in  2 `elem` list && 3 `elem` list
        isFlush (x:xs) = foldl (\acc y -> if getSuit x /= y then False else acc) True (suits xs)
        isStraight [x] = True
        isStraight xs  = if length (values xs) == length (nub (values xs)) && succ (head (sort (values xs))) `elem` (values xs) then isStraight (tail (sortBy sorting xs)) else False
        isThreeKind xs = xOfKind 3 xs
        isTwoPair xs   = sort [length l | l <- group (sort (values xs))] == [1,2,2]
        isPair xs      = xOfKind 2 xs
        values xs      = [getValue x | x <- xs]
        suits xs       = [getSuit x | x <- xs]
        sorting x y    = if getValue x < (getValue y) then LT else if getValue x > (getValue y) then GT else EQ
        xOfKind n xs   = maximum [length l | l <- (group (sort (values xs)))] == n

highCardValue :: Hand -> Value
highCardValue [] = error "Empty hand"
highCardValue xs = maximum [getValue x | x <- xs]