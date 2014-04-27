import Card
import PokerHand

royal = [(King,Heart),(Ten,Heart),(Queen,Heart),(Jack,Heart),(Ace,Heart)]
sflush = [(Eight,Diamond),(Five,Diamond),(Seven,Diamond),(Six,Diamond),(Four,Diamond)]
four = [(Five,Diamond),(Five,Club),(Five,Heart),(Jack,Spade),(Five,Spade)]
full = [(Ten,Spade),(Queen,Heart),(Ten,Heart),(Ten,Diamond),(Queen,Club)]
flush = [(Three,Diamond),(Six,Diamond),(King,Diamond),(Nine,Diamond),(Ace,Diamond)]
straight = [(Four,Club),(Eight,Heart),(Five,Heart),(Six,Spade),(Seven,Diamond)]
three = [(Six,Heart),(Two,Heart),(Six,Spade),(Six,Club),(Ten,Club)]
twopair = [(King,Diamond),(King,Club),(Jack,Club),(Four,Heart),(Jack,Heart)]
pair = [(Five,Heart),(Six,Heart),(Four,Heart),(Seven,Heart),(Six,Club)]
high = [(Nine,Club),(Four,Diamond),(King,Diamond),(Ten,Club),(Two,Spade)]

tryAll = map evaluateHand [royal,sflush,four,full,flush,straight,three,twopair,pair,high]