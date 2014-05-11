import Card
import Deck
import PokerHand

royal = [Card (King,Heart),Card (Ten,Heart),Card (Queen,Heart),Card (Jack,Heart),Card (Ace,Heart)]

sflush = [Card (Eight,Diamond),Card (Five,Diamond),Card (Seven,Diamond),Card (Six,Diamond),Card (Four,Diamond)]
sflush2 = [Card (Six,Spade),Card (Nine,Spade),Card (Eight,Spade),Card (Five,Spade),Card (Seven,Spade)]

four = [Card (Five,Diamond),Card (Five,Club),Card (Five,Heart),Card (Jack,Spade),Card (Five,Spade)]
four2 = [Card (Five,Diamond),Card (Five,Heart),Card (Ten,Club),Card (Five,Spade),Card (Five,Club)]
four3 = [Card (Two,Heart),Card (Seven,Club),Card (Seven,Diamond),Card (Seven,Heart),Card (Seven,Spade)]
four4 = [Card (Seven,Diamond),Card (Two,Spade),Card (Seven,Heart),Card (Seven,Diamond),Card (Seven,Club)]

full = [Card (Ten,Spade),Card (Queen,Heart),Card (Ten,Heart),Card (Ten,Diamond),Card (Queen,Club)]
full2 = [Card (Queen,Spade),Card (Nine,Spade),Card (Nine,Diamond),Card (Nine,Diamond),Card (Queen,Diamond)]
full3 = [Card (Ten,Spade),Card (Queen,Heart),Card (Ten,Heart),Card (Queen,Diamond),Card (Queen,Club)]
full4 = [Card (Queen,Spade),Card (Queen,Diamond),Card (Ten,Club),Card (Queen,Club),Card (Ten,Heart)]

flush = [Card (Three,Diamond),Card (Six,Diamond),Card (King,Diamond),Card (Nine,Diamond),Card (Ace,Diamond)]
flush2 = [Card (Nine,Club),Card (Seven,Club),Card (Queen,Club),Card (Ten,Club),Card (Three,Club)]
flush3 = [Card (Ten,Diamond),Card (Three,Diamond),Card (Seven,Diamond),Card (Nine,Diamond),Card (Queen,Diamond)]

straight = [Card (Four,Club),Card (Eight,Heart),Card (Five,Heart),Card (Six,Spade),Card (Seven,Diamond)]
straight2 = [Card (Ten,Diamond),Card (Eight,Heart),Card (Queen,Heart),Card (Nine,Club),Card (Jack,Diamond)]
straight3 = [Card (Queen,Heart),Card (Ten,Spade),Card (Jack,Spade),Card (Eight,Diamond),Card (Nine,Club)]
notstraight = [Card (King,Heart),Card (Ten,Spade),Card (Jack,Spade),Card (Eight,Diamond),Card (Nine,Club)]

three = [Card (Six,Heart),Card (Two,Heart),Card (Six,Spade),Card (Six,Club),Card (Ten,Club)]
three2 = [Card (Nine,Spade),Card (Ten,Heart),Card (Queen,Heart),Card (Ten,Club),Card (Ten,Diamond)]
three3 = [Card (Ten,Heart),Card (Ten,Spade),Card (Ten,Club),Card (Queen,Spade),Card (Nine,Diamond)]
three4 = [Card (Ten,Heart),Card (Ten,Spade),Card (Ten,Club),Card (Queen,Spade),Card (Eight,Diamond)]

twopair = [Card (King,Diamond),Card (King,Club),Card (Jack,Club),Card (Four,Heart),Card (Jack,Heart)]
twopair2 = [Card (Four,Diamond),Card (Four,Club),Card (Eight,Club),Card (Ace,Heart),Card (Eight,Heart)]
twopair3 = [Card (Eight,Spade),Card (Eight,Diamond),Card (Ace,Club),Card (Four,Heart),Card (Four,Spade)]
twopair4 = [Card (Eight,Spade),Card (Eight,Diamond),Card (King,Club),Card (Four,Heart),Card (Four,Spade)]

pair = [Card (Five,Heart),Card (Six,Heart),Card (Four,Heart),Card (Seven,Heart),Card (Six,Club)]
pair2 = [Card (Two,Heart),Card (Eight,Spade),Card (Eight,Club),Card (Nine,Club),Card (Jack,Spade)]
pair3 = [Card (Eight,Heart),Card (Jack,Diamond),Card (Nine,Diamond),Card (Eight,Diamond),Card (Two,Heart)]
pair4 = [Card (Eight,Heart),Card (Jack,Diamond),Card (Nine,Diamond),Card (Eight,Diamond),Card (Three,Heart)]

high = [Card (Nine,Club),Card (Four,Diamond),Card (King,Diamond),Card (Ten,Club),Card (Two,Spade)]
high2 = [Card (Four,Spade),Card (Ten,Heart),Card (Two,Club),Card (Nine,Club),Card (King,Heart)]
high3 = [Card (Nine,Diamond),Card (Ten,Diamond),Card (Three,Heart),Card (Four,Spade),Card (King,Spade)]

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