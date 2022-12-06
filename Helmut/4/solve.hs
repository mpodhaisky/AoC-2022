import Data.List.Split (splitOn)

g :: String -> [Int]
g = map read . splitOn "-" 

contains [a,b] [c,d] = ((a <= c) && ( d <= b )) || (( c <= a ) && ( b <= d ))

overlaps1 [a,b] [c,d] = ((c <= a) && ( a <= d )) || (( c <= b ) && ( b <= d ))

overlaps x y = (overlaps1 x y) || (overlaps1 y x)

check f line = let [p1,p2] = splitOn "," line
             in f (g p1) (g p2)
main = do
    small <- fmap lines $ readFile "small.txt"
    big <- fmap lines $ readFile "big.txt"
    print $ filter (check contains) small
    print $ filter (check overlaps) small
    print $ length $ filter (check contains) big
    print $ length $ filter (check overlaps) big
