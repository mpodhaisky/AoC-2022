import Data.Tree

parse '[' = "Node {rootLabel = Nothing, subForest = ["
parse ',' = ","
parse ']' = "]}"
parse n = "Node {rootLabel = Just "++[n]++",subForest = []}"

breakLines n = map (take n) . takeWhile (/=[]) . iterate (drop n)

readTree:: String->Tree (Maybe Int)
readTree = read

main = do
    input <- readFile "13test.txt"
    
    print.breakLines 2.map (readTree.concatMap parse).filter (/="").lines $ input
