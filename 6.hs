readInt:: String -> Int
readInt = read

marker:: String -> Int -> Int
marker xs n = if go (take 14 xs) then n else marker (tail xs) (n+1)
    where
        go [] = True
        go (x:xs) = and (map (/=x) xs) && go xs

main = do
    input <- readFile "6.txt"
    print $ marker input 14
