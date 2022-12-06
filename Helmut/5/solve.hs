clean = map head . takeWhile (/= "") . iterate (drop 4) . tail

g a b = if b /=' ' then b:a
                   else a
stacks txt = 
    let 
        blocks = map clean $ reverse $ init $ takeWhile (/="") txt
        m = (+1) $ length $ head blocks
        z0 = take m  (repeat []) :: [[Char]]
     in   foldl (zipWith g) z0  blocks

rd = fmap lines . readFile 

move stack (0, a, b) = stack
move stack (k, a, b) = let 
                      (x:aa) = stack!!a
                      bb = x:(stack!!b)
                   in move [ if k == a then aa
                                  else if k == b then bb
                                       else stack !!k 
                        | k <- [0..((length stack)-1)]]  (k-1, a, b)

phi [_,k,_,a,_,b] = (read k,  (read a)-1, (read b)-1) :: (Int,Int,Int)

moves txt = 
    let 
        s = stacks txt
        m = map (phi.words) $ tail $ dropWhile (/="") txt
    in foldl move s m 


main = do 
    s <- rd "big.txt"
    print $  map head $ moves s
    
