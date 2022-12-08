readInt:: String -> Int
readInt = read


visible:: String -> [Bool]
visible xs= [and $ map (<(xs!!(i-1))) (take (i-1) xs) | i<-[1..(length xs)]]

getter xs = filter (/=[]) (go xs 0 (length (head xs)))
    where
        go xs i n = if i==n then [[]] else (map (!!i) xs):go xs (i+1) n
        
ree True = 1
ree False = 0

length' [] = 1
length' xs = length xs

prod xs n = (length' (go' (reverse (take n xs)) (xs!!n)))*(length' (go' (drop (n+1) xs) (xs!!n)))
    where
        go' [] _ = []
        go' (x:xs) n = if x<n then (x:(go' xs n)) else [x] 

viewDistance::Int->Int->[String]->[String]->Int
viewDistance x y xs ys = prod (xs!!y) x * prod (ys!!x) y

main = do
    input <- readFile "8.txt"
    let ree1 = (zipWith (zipWith (||)) (map visible (lines input)) (map (reverse.visible.reverse) (lines input)))
    let ree2 = getter (zipWith (zipWith (||)) ((map visible (getter (lines input)))) ( (map (reverse.visible.reverse) (getter(lines input)))))
    let rows = lines input
    let cols = getter (lines input)
    print $ maximum [viewDistance x y rows cols| x<-[1..98],y<-[1..98]]

