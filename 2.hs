test=[('A', 'Y'),('B', 'X'),('C', 'Z')]

tuplify2:: [String] -> (Char,Char)
tuplify2 [x,y] = (head x,head y)

nums:: Char-> Int
nums 'A' = 1
nums 'B' = 2
nums 'C' = 3
nums 'X' = 1
nums 'Y' = 2
nums 'Z' = 3

convert [] = []
convert ((a,b):ts) = (nums a, nums b):(convert ts)

points:: (Int, Int) -> Int
points (a, b) 
    | a == b = b+3
    | mod a 3 == mod (b+1) 3 =b
    | mod a 3 == mod (b-1) 3 =b+6

points':: (Int, Int) -> Int
points' (a, b) 
    | b == 2 = 3+a
    | b == 1 = 1+mod (a-2) 3
    | otherwise = 7+mod a 3

main = do
    input <- readFile "2"
    let content = map (tuplify2 . words) . lines  $ input
    --tests
    print . sum $ map points (convert test)
    print . sum $ map points' (convert test)
    --solutions
    print . sum $ map points (convert content)
    print . sum $ map points' (convert content)