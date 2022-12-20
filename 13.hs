data Exp = Bracket [Exp] | Num Int deriving (Show, Read,Eq)

parse:: String->String
parse ('[':xs) = "Bracket ["++parse xs
parse (',':xs) = ","++parse xs
parse (']':xs) = "]"++parse xs
parse [] = []
parse (xs) = "Num "++(takeWhile condition xs)++parse (dropWhile condition xs)
    where
        condition a = or $ map (==(a:"")) (map show (take 10 (iterate (+1) 0)))
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

quicksort [] = []
quicksort (x:xs) = quicksort (filter ( (==1).(`comp` x)) xs) ++[x] ++ quicksort (filter ( (==2).(`comp` x)) xs)

g:: [Exp] ->Int->Exp ->Int
g a b c= if (c `elem`a) then b else 1
main = do
    input <- readFile "13.txt"
    let dividers = [Bracket[ Bracket [Num 2]] ,Bracket [Bracket [Num 6]]]
    print.sum.zipWith f (iterate (+1) 1).map (comp'.map(readTree.parse)).breakLines 2.filter (/="").lines $ input
    print.product.(zipWith (g dividers) (iterate (+1) 1)).quicksort.(++dividers).map (readTree.parse).filter (/="").lines $ input
