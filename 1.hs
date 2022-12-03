readInt:: String -> Int
readInt = read

maxsum _ 0 = 0
maxsum xs n = maximum xs + maxsum (filter (/=maximum xs) xs) (n-1)

tail' [] = []
tail' xs = tail xs

splitter:: [String] -> [Int]
splitter xs =go xs 
    where
        go [] = [0]
        go xs = go1 $ span (/="") xs
        go1 (a,b) = (sum . map readInt $ a):(go $ tail' b)

main = do
    input <- readFile "1"
    --solutions
    print . maximum . splitter . lines $ input
    print . (`maxsum` 3) . splitter . lines $ input