readInt:: String -> Int
readInt = read

main = do
    input <- readFile "6.txt"
    print . map (map readInt . words). lines $ input