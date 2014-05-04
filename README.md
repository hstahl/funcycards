funcycards
==========
A simple poker game made as a functional programming exercise

### Getting started
Compile the game with `ghc .\funcycards.hs`<br>
Alternatively, run `ghci` and do `:l funcycards` and then call `main`.

### How to play
* The command line game will first ask for the names of the players. Write one name on each line and leave an empty line when you are done.
* Next, the game will deal cards to each player and ask you to discard the ones you want. The hand you have is shown as a enumerated list. Input the numbers of the cards you want to discard seperated by spaces.
* Finally, the game will show everyone's hands and announce the winner.