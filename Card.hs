module Card (
  Suit(..),
  Value(..),
  Card(..),
  getValue,
  getSuit
) where

data Suit = Club | Diamond | Spade | Heart
            deriving (Eq, Ord, Bounded, Enum, Show, Read)

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

newtype Card = Card { face :: (Value,Suit) } deriving (Eq)

instance Ord Card where
    compare a b = compare (fst (face a)) (fst (face b))

instance Show Card where
    show = show . face

getValue :: Card -> Value
getValue = fst . face

getSuit :: Card -> Suit
getSuit = snd . face
