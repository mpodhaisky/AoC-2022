data Exp = Bracket [Exp] | Num Int deriving (Show, Read)

parse:: String->String
parse ('[':xs) = "Bracket ["++parse xs
parse (',':xs) = ","++parse xs
parse (']':xs) = "]"++parse xs
parse [] = []
parse (xs) = "Num "++(takeWhile condition xs)++parse (dropWhile condition xs)
    where
        condition a = or $ map (==(a:"")) (map show (take 10 (iterate ((+1)) 0)))
breakLines n = map (take n) . takeWhile (/=[]) . iterate (drop n)

readTree:: String->Exp
readTree = read

comp (Num l) (Num r) = if l==r then 0 else if l<r then 1 else 2
comp (Num l) r = comp (Bracket [Num l]) r 
comp l (Num r) = comp l (Bracket [Num r])
comp (Bracket (l:ls)) (Bracket (r:rs)) = if comp l r ==0 then comp (Bracket ls) (Bracket rs) else comp l r
comp (Bracket []) (Bracket []) = 0
comp (Bracket []) _ = 1
comp _ _ = 2

comp' [a , b] = comp a b

f a b = if b == 1 then a else 0

main = do
    input <- readFile "13.txt"
    
    print.sum.zipWith f (iterate (+1) 1).map (comp'.map(readTree.parse)).breakLines 2.filter (/="").lines $ input
