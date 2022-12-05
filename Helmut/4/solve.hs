import Data.List.Split (splitOn)

g :: String -> [Int]
g = map read . splitOn "-" 

contains [a,b] [c,d] = ((a <= c) && ( d <= b )) || (( c <= a ) && ( b <= d ))

check line = let [p1,p2] = splitOn "," line
             in contains (g p1) (g p2)
main = do
    small <- fmap lines $ readFile "small.txt"
    big <- fmap lines $ readFile "big.txt"
    print $ filter check small
    print $ length $ filter check big
