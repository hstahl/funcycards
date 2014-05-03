import Card
import Deck
import PokerHand
import Game
import Player
import System.Random

main = do
    gen <- getStdGen
    let game1 = newGame [player1,player2,player3,player4,player5] (shuffle gen newDeck)
        (game2,cards) = takeLFromDeck game1 [1,1,1,1,1]
        game3 = pickThese game2 cards
        discardall = [hand (givePlayer game3 0),
                     [],
                     [],
                     [],
                     []]
        game4 = discardThese game3 discardall
    print (fst game3)
    print (fst game4)

player1 = Player "Keijo" []
player2 = Player "Keppo" []
player3 = Player "Kalle" []
player4 = Player "Kaarina" []
player5 = Player "Kuisma" []
