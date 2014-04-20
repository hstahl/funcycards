module Card (
  Suit(..),
  Value(..),
  Card(..)
) where

data Suit = Heart | Spade | Diamond | Club
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