import Data.Char (ord, isLower)
import Data.List (intersect, nub)

e c = if isLower c then 1 + ord c - ord 'a'
                   else 27 + ord c - ord 'A'

f r = let (a,b) = splitAt (div (length r) 2) r
      in head $ map e $ intersect a b

gr3 :: [String] -> [Char]
gr3 = map (head . nub . foldl1 intersect . take 3) . takeWhile (/=[]) . iterate (drop 3) 

main = do 
    input <- readFile "input.txt"
    print . sum . map f . lines $ input
    print . sum . map e . gr3. lines $ input
