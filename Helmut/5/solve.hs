-- f xs l = 
stacks txt = 
    let 
        blocks = reverse $ init $ takeWhile (/="") txt
        m = div  ((+1) $ length $ head blocks) 4
        z0 = take m  (repeat []) :: [[Char]]
     in z0

main = do 
    txt <- fmap lines $ readFile "small.txt"
    print(stacks txt)
    
