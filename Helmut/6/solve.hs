import Data.List (tails, nub)

check :: String -> Int
check = (4+) . length . takeWhile (<4) . map (length . nub . take 4) . tails

main = do
    print $ check "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
    print $ check "nppdvjthqldpwncqszvftbrmjlhg"
    fmap check (readFile "input") 
