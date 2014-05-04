{-
 - A command line interface for a poker game.
 -
 - Input: Names of players (1-5)
 -        Empty line when done
 -
 - Each player on their turn will select
 - the cards they want to discard
 -
 - After discarding, the hands are filled
 - up to 5 cards each again and the winner
 - is announced.
 -}

import System.Random
import Card
import Deck
import PokerHand
import Player
import Game

main = do
    --fetch a random generator
    gen <- getStdGen
    --ask player names and add to game
    putStrLn "Player names:"
    playernames <- askNames []
    --show the names of the participants
    putStrLn $ printList playernames
    let fulldeck = shuffle gen newDeck
        --create list of players without cards
        players = map (\x -> Player x []) playernames
        --create game
        newgame = newGame players fulldeck
        --initial state is when five cards are drawn from the deck for each player
        (initialState,dealFiveEach) = takeLFromDeck newgame $ (take (length playernames) . repeat) 5
        --discard state is when players are holding five cards and those cards were removed from the deck
        discardState = pickThese initialState dealFiveEach
    --show hands and ask for discards
    putStrLn $ printList (zipWith (\a b -> a ++ "'s Hand: " ++ show b) playernames [hand p | p <- fst discardState])
    discardList <- askDiscards (fst discardState)
        --discarded state is when the selected cards have been removed from the players' hands
    let discardedState = discardThese discardState discardList
        missingCards = [5 - length (hand x) | x <- fst discardedState]
        --pick up state is when the replacement cards for discarded ones are taken from the deck
        (pickUpState,newCards) = takeLFromDeck discardedState missingCards
        --refill state is when the replacement cards are given to the players
        refillState = pickThese pickUpState newCards
    --show final hands
    putStrLn $ printList (zipWith (\a b -> a ++ "'s Hand: " ++ show b) playernames [hand p | p <- fst refillState])
    --announce winner
    putStrLn $ "The winner is: " ++ (name . giveWinner . fst) refillState ++ "!"

askNames :: [String] -> IO [String]
askNames xs = do
    name <- getLine
    if null name
        then return xs
        else askNames (xs ++ [name])

askDiscards :: [Player] -> IO [[Card]]
askDiscards [] = do return [[]]
askDiscards xp = do
    putStrLn $ "Which cards will you discard, " ++ (name (head xp)) ++ "?"
    putStrLn $ printList (hand (head xp))
    line <- getLine
    let selection = words line
        intselection :: [String] -> [Int]
        intselection [] = []
        intselection xs = read (head xs) : intselection (tail xs)
        discards = giveDiscards (head xp) (intselection selection)
    fmap (discards:) $ askDiscards (tail xp)

giveDiscards :: Player -> [Int] -> [Card]
giveDiscards _ [] = []
giveDiscards p xs = hand p !! head xs : giveDiscards p (tail xs)

printList :: (Show a) => [a] -> String
printList = unlines . zipWith (\n a -> show n ++ " - " ++ show a) [0..]
