import Card
import PokerHand

royal = [(King,Heart),(Ten,Heart),(Queen,Heart),(Jack,Heart),(Ace,Heart)]

sflush = [(Eight,Diamond),(Five,Diamond),(Seven,Diamond),(Six,Diamond),(Four,Diamond)]
sflush2 = [(Six,Spade),(Nine,Spade),(Eight,Spade),(Five,Spade),(Seven,Spade)]

four = [(Five,Diamond),(Five,Club),(Five,Heart),(Jack,Spade),(Five,Spade)]
four2 = [(Five,Diamond),(Five,Heart),(Ten,Club),(Five,Spade),(Five,Club)]
four3 = [(Two,Heart),(Seven,Club),(Seven,Diamond),(Seven,Heart),(Seven,Spade)]
four4 = [(Seven,Diamond),(Two,Spade),(Seven,Heart),(Seven,Diamond),(Seven,Club)]

full = [(Ten,Spade),(Queen,Heart),(Ten,Heart),(Ten,Diamond),(Queen,Club)]
full2 = [(Queen,Spade),(Nine,Spade),(Nine,Diamond),(Nine,Diamond),(Queen,Diamond)]
full3 = [(Ten,Spade),(Queen,Heart),(Ten,Heart),(Queen,Diamond),(Queen,Club)]
full4 = [(Queen,Spade),(Queen,Diamond),(Ten,Club),(Queen,Club),(Ten,Heart)]

flush = [(Three,Diamond),(Six,Diamond),(King,Diamond),(Nine,Diamond),(Ace,Diamond)]
flush2 = [(Nine,Club),(Seven,Club),(Queen,Club),(Ten,Club),(Three,Club)]
flush3 = [(Ten,Diamond),(Three,Diamond),(Seven,Diamond),(Nine,Diamond),(Queen,Diamond)]

straight = [(Four,Club),(Eight,Heart),(Five,Heart),(Six,Spade),(Seven,Diamond)]
straight2 = [(Ten,Diamond),(Eight,Heart),(Queen,Heart),(Nine,Club),(Jack,Diamond)]
straight3 = [(Queen,Heart),(Ten,Spade),(Jack,Spade),(Eight,Diamond),(Nine,Club)]

three = [(Six,Heart),(Two,Heart),(Six,Spade),(Six,Club),(Ten,Club)]
three2 = [(Nine,Spade),(Ten,Heart),(Queen,Heart),(Ten,Club),(Ten,Diamond)]
three3 = [(Ten,Heart),(Ten,Spade),(Ten,Club),(Queen,Spade),(Nine,Diamond)]
three4 = [(Ten,Heart),(Ten,Spade),(Ten,Club),(Queen,Spade),(Eight,Diamond)]

twopair = [(King,Diamond),(King,Club),(Jack,Club),(Four,Heart),(Jack,Heart)]
twopair2 = [(Four,Diamond),(Four,Club),(Eight,Club),(Ace,Heart),(Eight,Heart)]
twopair3 = [(Eight,Spade),(Eight,Diamond),(Ace,Club),(Four,Heart),(Four,Spade)]
twopair4 = [(Eight,Spade),(Eight,Diamond),(King,Club),(Four,Heart),(Four,Spade)]

pair = [(Five,Heart),(Six,Heart),(Four,Heart),(Seven,Heart),(Six,Club)]
pair2 = [(Two,Heart),(Eight,Spade),(Eight,Club),(Nine,Club),(Jack,Spade)]
pair3 = [(Eight,Heart),(Jack,Diamond),(Nine,Diamond),(Eight,Diamond),(Two,Heart)]
pair4 = [(Eight,Heart),(Jack,Diamond),(Nine,Diamond),(Eight,Diamond),(Three,Heart)]

high = [(Nine,Club),(Four,Diamond),(King,Diamond),(Ten,Club),(Two,Spade)]
high2 = [(Four,Spade),(Ten,Heart),(Two,Club),(Nine,Club),(King,Heart)]
high3 = [(Nine,Diamond),(Ten,Diamond),(Three,Heart),(Four,Spade),(King,Spade)]

tryAll = map evaluateHand [high,pair,twopair,three,straight,flush,full,four,sflush,royal]
isCorrect = tryAll == [HighCard,Pair,TwoPair,ThreeOfAKind,Straight,Flush,FullHouse,FourOfAKind,StraightFlush,RoyalFlush]

testAll = testHigh && testPair && testTwoPair && testThree && testStraight && testFlush && testFull && testFour && testSflush

testHigh = compareHands high high2 == EQ &&
           compareHands high2 high == EQ &&
           compareHands high2 high3 == LT &&
           compareHands high3 high2 == GT

testPair = compareHands pair pair2 == LT &&
           compareHands pair2 pair == GT &&
           compareHands pair2 pair3 == EQ &&
           compareHands pair3 pair2 == EQ &&
           compareHands pair3 pair4 == LT &&
           compareHands pair4 pair3 == GT

testTwoPair = compareHands twopair twopair2 == GT &&
              compareHands twopair2 twopair == LT &&
              compareHands twopair2 twopair3 == EQ &&
              compareHands twopair3 twopair2 == EQ &&
              compareHands twopair3 twopair4 == GT &&
              compareHands twopair4 twopair3 == LT
  
testThree = compareHands three three2 == LT &&
            compareHands three2 three == GT &&
            compareHands three2 three3 == EQ &&
            compareHands three3 three2 == EQ &&
            compareHands three3 three4 == GT &&
            compareHands three4 three3 == LT

testStraight = compareHands straight straight2 == LT &&
               compareHands straight2 straight == GT &&
               compareHands straight2 straight3 == EQ &&
               compareHands straight3 straight2 == EQ

testFlush = compareHands flush flush2 == GT &&
            compareHands flush2 flush == LT &&
            compareHands flush2 flush3 == EQ &&
            compareHands flush3 flush2 == EQ

testFull = compareHands full full2 == GT &&
           compareHands full2 full == LT &&
           compareHands full full3 == LT &&
           compareHands full3 full == GT &&
           compareHands full3 full4 == EQ &&
           compareHands full4 full3 == EQ

testFour = compareHands four four2 == GT &&
           compareHands four2 four == LT &&
           compareHands four four3 == LT &&
           compareHands four3 four == GT &&
           compareHands four3 four4 == EQ &&
           compareHands four4 four3 == EQ

testSflush = compareHands sflush sflush2 == LT &&
             compareHands sflush2 sflush == GT