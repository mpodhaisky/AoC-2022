readInt:: String -> Int
readInt = read

main = do
    input <- readFile "14test.txt"
    print .map (filter (/="->").words).lines$input