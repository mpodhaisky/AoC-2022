# So sieht das in GHCi aus

mit `:set +` schaltet man die Typinformation an

```haskell
[helmut@t480 9]$ ghci
GHCi, version 8.10.7: https://www.haskell.org/ghc/  :? for help
Prelude> 
Leaving GHCi.
[helmut@t480 9]$ ghci
GHCi, version 8.10.7: https://www.haskell.org/ghc/  :? for help
Prelude> :set +t
Prelude> :l solve.hs
[1 of 1] Compiling Main             ( solve.hs, interpreted )
Ok, one module loaded.
*Main> test1
[(1,0),(1,0),(1,0),(1,0),(0,1),(0,1),(0,1),(0,1)]
it :: Moves
*Main> test2
[(1,0),(0,0)]
it :: Schlange
*Main> test3
[(4,4),(4,3)]
it :: Schlange
*Main> main
[13,36,2327]
it :: [Int]
```
