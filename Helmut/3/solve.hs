import Data.Char (ord, isLower)
import Data.List (intersect)

e c = if isLower c then 1 + ord c - ord 'a'
                   else 27 + ord c - ord 'A'

f r = let (a,b) = splitAt (div (length r) 2) r
      in head $ map e $ intersect a b


main = do 
    fmap (sum . map f . lines) $ readFile "small.txt"
    fmap (sum . map f . lines) $ readFile "input.txt"
