readInt:: String -> Int
readInt = read


visible:: String -> [Bool]
visible xs= [and $ map (<(xs!!(i-1))) (take (i-1) xs) | i<-[1..(length xs)]]

getter xs = filter (/=[]) (go xs 0 (length (head xs)))
    where
        go xs i n = if i==n then [[]] else (map (!!i) xs):go xs (i+1) n
        
toNum True = 1
toNum False = 0

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
    tinput <- readFile "8test.txt"
    
    let tree1 = (zipWith (zipWith (||)) (map visible (lines tinput)) (map (reverse.visible.reverse) (lines tinput)))
    let tree2 = getter (zipWith (zipWith (||)) ((map visible (getter (lines tinput)))) ( (map (reverse.visible.reverse) (getter(lines tinput)))))
    
    let ree1 = (zipWith (zipWith (||)) (map visible (lines input)) (map (reverse.visible.reverse) (lines input)))
    let ree2 = getter (zipWith (zipWith (||)) ((map visible (getter (lines input)))) ( (map (reverse.visible.reverse) (getter(lines input)))))
    --solution part one
    print . sum.map (sum.map toNum)$ zipWith (zipWith (||)) tree1 tree2
    print . sum.map (sum.map toNum)$ zipWith (zipWith (||)) ree1 ree2
    
    let rows = lines input
    let cols = getter (lines input)
    let trows = lines tinput
    let tcols = getter (lines tinput)

    --solution part two
    print $ maximum [viewDistance x y trows tcols| x<-[1..3],y<-[1..3]]
    print $ maximum [viewDistance x y rows cols| x<-[1..98],y<-[1..98]]
