split xs = splitAt (div (length xs) 2 ) xs

common (a, "") = 'z'
common (a, (b:bs)) = if or $ map (==b) a then b else common (a, bs)

convert c
    | fromEnum c >= 97 =fromEnum c -96
    | otherwise =fromEnum c -38

split3 [] = []
split3 xs = (take 3 xs):(split3 (drop 3 xs))

tuplify3 [a,b,c] = (a,b,c)

comp3 (a,b,(c:cs)) = if (or $ map (==c) a) && (or $ map (==c) b) then c else comp3(a,b,cs)


main = do
    input <- readFile "3.txt"
    print . sum .map (convert.common . split) . lines $input
    print .sum. map (convert.comp3.tuplify3) . split3 . lines $input