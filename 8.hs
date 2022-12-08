readInt:: String -> Int
readInt = read

visible:: String -> [Bool]
visible xs = (`fill` length xs).takeWhile (==True) . (True:).(zipWith (<) <*> tail) $ xs

fill xs n = xs ++ [False | i<-[1..n-(length xs)]]

getter xs = filter (/=[]) (go xs 0 (length (head xs)))
    where
        go xs i n = if i==n then [[]] else (map (!!i) xs):go xs (i+1) n
        
ree True = 1
ree False = 0
main = do
    input <- readFile "8.txt"
    print .sum $map (sum.map (ree)) (zipWith (zipWith (||)) (zipWith (zipWith (||)) (map visible (lines input)) (map (reverse.visible.reverse) (lines input))) (zipWith (zipWith (||)) (getter (map visible (getter (lines input)))) (getter (map (reverse.visible.reverse) (getter(lines input))))))
    print $ lines input
    print $ (zipWith (zipWith (||)) (map visible (lines input)) (map (reverse.visible.reverse) (lines input)))
    print $ getter (lines input)
    print $ (zipWith (zipWith (||)) (getter (map visible (getter (lines input)))) (getter (map (reverse.visible.reverse) (getter(lines input)))))
