readInt:: String -> Int
readInt = read


smallerThan [[], []] = 0
smallerThan [[], _] = 1
smallerThan [_, []] = 0
smallerThan [(a:as),(b:bs)] 
    | a==b = smallerThan [as,bs] 
    | a<b = 1
    | a>b = 0

breakLines n = map (take n) . takeWhile (/=[]) . iterate (drop n)
parse ']' = ' '
parse '[' = ' '
parse c = c

count xs = go xs 1
    where
        go [] _= 0
        go (x:xs) n = if x==1 then n+(go xs (n+1)) else (go xs (n+1))

main = do
    input <- readFile "13.txt"
    print .count.map smallerThan.breakLines 2.map words.filter (/="").map ((map parse).filter (/=',')).lines $ input
