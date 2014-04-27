module Card (
  Suit(..),
  Value(..),
  Card(..),
  getValue,
  getSuit
) where

data Suit = Club | Diamond | Spade | Heart
            deriving (Bounded, Enum, Show, Read)

instance Eq Suit where
    x == y = True

instance Ord Suit where
    x <= y = True

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