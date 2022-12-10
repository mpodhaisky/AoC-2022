readInt:: String -> Int
readInt = read

parse "noop" =  [(0,1)]
parse ('a':'d':'d':'x':' ':xs)= [(0,1),((read (xs)),1)]

addT (a,b) (c,d) = (a+c,b+d)
prodT (a,b) = a*(b+1)

filterino (_,19)= True
filterino (_,59)= True
filterino (_,99) = True
filterino (_,139) = True
filterino (_,179) = True
filterino (_,219) = True
filterino _ = False

eval (x,t) = if abs (t`mod`40-x) <=1 then "#" else "." 
main = do
    input <- readFile "10.txt"
    print .sum.map prodT.filter filterino.scanl addT (1,0).concatMap parse.lines $ input
    print.filter (/=' ') .unwords.map eval.tail.scanl addT (1,0).concatMap parse.lines $ input