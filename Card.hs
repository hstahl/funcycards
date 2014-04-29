module Card (
  Suit(..),
  Value(..),
  Card(..),
  getValue,
  getSuit,
  sorting
) where

data Suit = Club | Diamond | Spade | Heart
            deriving (Eq, Bounded, Enum, Show, Read)

data Value = Two
           | Three
           | Four
           | Five
           | Six
           | Seven
           | Eight
           | Nine
           | Ten
           | Jack
           | Queen
           | King
           | Ace
           deriving (Eq, Ord, Bounded, Enum, Show, Read)

type Card = (Value,Suit)

getValue :: Card -> Value
getValue x = fst x

getSuit :: Card -> Suit
getSuit x = snd x

{-
 - An Ordering for cards. Cards are ordered by face value.
 - Card of the same value and different suit are equal.
 -}
sorting :: Card -> Card -> Ordering
sorting xs ys = if getValue xs < (getValue ys) then LT else if getValue xs > (getValue ys) then GT else EQ