## This is a simple Haskell Program that takes in a set of live cells (i.e the 0-th state), a natural number n, and returns a set of live cells after n iterations in [the game of life](https://en.wikipedia.org/wiki/The_Game_of_Life) (i.e. the n-th state).

Each live cell is represented by an ordered pair i.e. a pair in Haskell e.g. `(0,0)`,  and each state is represented by a set of cells i.e. (for the sake of simplicity) a list of paris in Haskell e.g. `[(0,0)]` .

This is certainly not the most efficient implementation of the Game of Life, nor is it the shortest implementation (sorry to disappoint you [code-golffer](https://en.wikipedia.org/wiki/Code_golf)). But this is no doubt among the simplest ways to write the game of life using the functional approach.

In this implementation, the function `survive` is responsible for the 1st, 2nd and 3rd rules, namely *"a live cell stays alive [iff](https://en.wikipedia.org/wiki/If_and_only_if) it has 2 and 3 neighbours"*, while the function `produce` is responsible for the 4th rule, namely *"iff exactly 3 live cells has a neighbour in common, and that neighbour is not a live cell, it would be alive after this iteration"*.

## Quick Start

```
cabal run
```

## Most functions in this implementation are structurally recursive

Basically, a function `f` is structurally recursive when the return is either

1. calling `f` again, or some other function that calls `f`

2. some value (aka the base-case).

Here is an example:

```
powerset [] = [[]]
powerset (x:xs) = [ x:ns | ns <- recursion] ++ recursion
  where recursion = powerset xs
```

This would return the [power set](https://en.wikipedia.org/wiki/Power_set) equivalence of a list.
