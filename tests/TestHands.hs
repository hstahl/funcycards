import Card
import Deck
import PokerHand

royal = Hand [Card (King,Heart),Card (Ten,Heart),Card (Queen,Heart),Card (Jack,Heart),Card (Ace,Heart)]

sflush = Hand [Card (Eight,Diamond),Card (Five,Diamond),Card (Seven,Diamond),Card (Six,Diamond),Card (Four,Diamond)]
sflush2 = Hand [Card (Six,Spade),Card (Nine,Spade),Card (Eight,Spade),Card (Five,Spade),Card (Seven,Spade)]

four = Hand [Card (Five,Diamond),Card (Five,Club),Card (Five,Heart),Card (Jack,Spade),Card (Five,Spade)]
four2 = Hand [Card (Five,Diamond),Card (Five,Heart),Card (Ten,Club),Card (Five,Spade),Card (Five,Club)]
four3 = Hand [Card (Two,Heart),Card (Seven,Club),Card (Seven,Diamond),Card (Seven,Heart),Card (Seven,Spade)]
four4 = Hand [Card (Seven,Diamond),Card (Two,Spade),Card (Seven,Heart),Card (Seven,Diamond),Card (Seven,Club)]

full = Hand [Card (Ten,Spade),Card (Queen,Heart),Card (Ten,Heart),Card (Ten,Diamond),Card (Queen,Club)]
full2 = Hand [Card (Queen,Spade),Card (Nine,Spade),Card (Nine,Diamond),Card (Nine,Diamond),Card (Queen,Diamond)]
full3 = Hand [Card (Ten,Spade),Card (Queen,Heart),Card (Ten,Heart),Card (Queen,Diamond),Card (Queen,Club)]
full4 = Hand [Card (Queen,Spade),Card (Queen,Diamond),Card (Ten,Club),Card (Queen,Club),Card (Ten,Heart)]

flush = Hand [Card (Three,Diamond),Card (Six,Diamond),Card (King,Diamond),Card (Nine,Diamond),Card (Ace,Diamond)]
flush2 = Hand [Card (Nine,Club),Card (Seven,Club),Card (Queen,Club),Card (Ten,Club),Card (Three,Club)]
flush3 = Hand [Card (Ten,Diamond),Card (Three,Diamond),Card (Seven,Diamond),Card (Nine,Diamond),Card (Queen,Diamond)]

straight = Hand [Card (Four,Club),Card (Eight,Heart),Card (Five,Heart),Card (Six,Spade),Card (Seven,Diamond)]
straight2 = Hand [Card (Ten,Diamond),Card (Eight,Heart),Card (Queen,Heart),Card (Nine,Club),Card (Jack,Diamond)]
straight3 = Hand [Card (Queen,Heart),Card (Ten,Spade),Card (Jack,Spade),Card (Eight,Diamond),Card (Nine,Club)]
notstraight = Hand [Card (King,Heart),Card (Ten,Spade),Card (Jack,Spade),Card (Eight,Diamond),Card (Nine,Club)]

three = Hand [Card (Six,Heart),Card (Two,Heart),Card (Six,Spade),Card (Six,Club),Card (Ten,Club)]
three2 = Hand [Card (Nine,Spade),Card (Ten,Heart),Card (Queen,Heart),Card (Ten,Club),Card (Ten,Diamond)]
three3 = Hand [Card (Ten,Heart),Card (Ten,Spade),Card (Ten,Club),Card (Queen,Spade),Card (Nine,Diamond)]
three4 = Hand [Card (Ten,Heart),Card (Ten,Spade),Card (Ten,Club),Card (Queen,Spade),Card (Eight,Diamond)]

twopair = Hand [Card (King,Diamond),Card (King,Club),Card (Jack,Club),Card (Four,Heart),Card (Jack,Heart)]
twopair2 = Hand [Card (Four,Diamond),Card (Four,Club),Card (Eight,Club),Card (Ace,Heart),Card (Eight,Heart)]
twopair3 = Hand [Card (Eight,Spade),Card (Eight,Diamond),Card (Ace,Club),Card (Four,Heart),Card (Four,Spade)]
twopair4 = Hand [Card (Eight,Spade),Card (Eight,Diamond),Card (King,Club),Card (Four,Heart),Card (Four,Spade)]

pair = Hand [Card (Five,Heart),Card (Six,Heart),Card (Four,Heart),Card (Seven,Heart),Card (Six,Club)]
pair2 = Hand [Card (Two,Heart),Card (Eight,Spade),Card (Eight,Club),Card (Nine,Club),Card (Jack,Spade)]
pair3 = Hand [Card (Eight,Heart),Card (Jack,Diamond),Card (Nine,Diamond),Card (Eight,Diamond),Card (Two,Heart)]
pair4 = Hand [Card (Eight,Heart),Card (Jack,Diamond),Card (Nine,Diamond),Card (Eight,Diamond),Card (Three,Heart)]

high = Hand [Card (Nine,Club),Card (Four,Diamond),Card (King,Diamond),Card (Ten,Club),Card (Two,Spade)]
high2 = Hand [Card (Four,Spade),Card (Ten,Heart),Card (Two,Club),Card (Nine,Club),Card (King,Heart)]
high3 = Hand [Card (Nine,Diamond),Card (Ten,Diamond),Card (Three,Heart),Card (Four,Spade),Card (King,Spade)]

--tryAll = map evaluateHand [high,pair,twopair,three,straight,flush,full,four,sflush,royal]
--isCorrect = tryAll == [HighCard,Pair,TwoPair,ThreeOfAKind,Straight,Flush,FullHouse,FourOfAKind,StraightFlush,RoyalFlush]

testAll = testHigh && testPair && testTwoPair && testThree && testStraight && testFlush && testFull && testFour && testSflush

testHigh = compare high high2 == EQ &&
           compare high2 high == EQ &&
           compare high2 high3 == LT &&
           compare high3 high2 == GT

testPair = compare pair pair2 == LT &&
           compare pair2 pair == GT &&
           compare pair2 pair3 == EQ &&
           compare pair3 pair2 == EQ &&
           compare pair3 pair4 == LT &&
           compare pair4 pair3 == GT

testTwoPair = compare twopair twopair2 == GT &&
              compare twopair2 twopair == LT &&
              compare twopair2 twopair3 == EQ &&
              compare twopair3 twopair2 == EQ &&
              compare twopair3 twopair4 == GT &&
              compare twopair4 twopair3 == LT
  
testThree = compare three three2 == LT &&
            compare three2 three == GT &&
            compare three2 three3 == EQ &&
            compare three3 three2 == EQ &&
            compare three3 three4 == GT &&
            compare three4 three3 == LT

testStraight = compare straight straight2 == LT &&
               compare straight2 straight == GT &&
               compare straight2 straight3 == EQ &&
               compare straight3 straight2 == EQ

testFlush = compare flush flush2 == GT &&
            compare flush2 flush == LT &&
            compare flush2 flush3 == EQ &&
            compare flush3 flush2 == EQ

testFull = compare full full2 == GT &&
           compare full2 full == LT &&
           compare full full3 == LT &&
           compare full3 full == GT &&
           compare full3 full4 == EQ &&
           compare full4 full3 == EQ

testFour = compare four four2 == GT &&
           compare four2 four == LT &&
           compare four four3 == LT &&
           compare four3 four == GT &&
           compare four3 four4 == EQ &&
           compare four4 four3 == EQ

testSflush = compare sflush sflush2 == LT &&
             compare sflush2 sflush == GT