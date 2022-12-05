stacks txt = 
    let 
        blocks = reverse $ init $ takeWhile (/="") txt
        m = div  ((+1) $ length $ head blocks) 4
    in  m

main = do 
    txt <- fmap lines $ readFile "small.txt"
    print(stacks txt)
    