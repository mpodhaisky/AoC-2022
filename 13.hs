smallerThan [[], []] = 0
smallerThan [[], _] = 1
smallerThan [_, []] = 0
smallerThan [(a:as),(b:bs)] 
    | a==b = smallerThan [as,bs] 
    | a<b = 1
    | a>b = 0

breakLines n = map (take n) . takeWhile (/=[]) . iterate (drop n)

count xs = go xs 1
    where
        go [] _= 0
        go (x:xs) n = if x==1 then n+(go xs (n+1)) else (go xs (n+1))

main = do
    input <- readFile "13test.txt"
    print .breakLines 2.filter (/="").map (filter (/=',')).lines $ input
