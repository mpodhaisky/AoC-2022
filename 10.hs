parse "noop" =  [(0,1)]
parse xs= [(0,1),((read (drop 5 xs)),1)]

addT (a,b) (c,d) = (a+c,b+d)

prodT (a,b) = a*b

filter40 (_,n)= (n-20)`mod`40==0

eval (x,t) = if abs (t`mod`40-x) <=1 then "#" else "." 

breakLines :: Int -> String -> String
breakLines n = unlines . map (take n) . takeWhile (/=[]) . iterate (drop n)

main = do
    input <- readFile "10.txt"
    print .sum.map prodT.filter filter40.scanl addT (1,1).concatMap parse.lines $ input
    putStrLn . breakLines 40. concatMap eval.scanl addT (1,0).concatMap parse.lines $ input
