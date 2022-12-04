readInt:: String -> Int
readInt = read

maxsum _ 0 = 0
maxsum xs n = maximum xs + maxsum (filter (/=maximum xs) xs) (n-1)

main = do
    input <- readFile "1.txt"
    --solutions
    print . maximum .map (sum .map readInt . words). lines $ input
    print . (`maxsum` 3) .map (sum .map readInt . words). lines $ input