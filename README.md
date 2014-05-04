funcycards
==========
A simple poker game made as a functional programming exercise

### Getting started
Compile the game with `ghc .\funcycards.hs`<br>
Alternatively, run `ghci` and do `:l funcycards` and then call `main`.

### How to play
1. The command line game will first ask for the names of the players. Write one name on each line and leave an empty line when you are done. The game allows a maximum of five players.
2. Next, the game will deal cards to each player and ask you to discard the ones you want. The hand you have is shown as an enumerated list. Input the numbers of the cards you want to discard seperated by spaces.
3. Finally, the game will show everyone's hands and announce the winner.