-- etwas stimmt noch nicht !!!
--
import Data.Char (ord)

c [a,b] = (ord (head a)  - ord 'A', ord (head b) - ord 'X')

ev (a,b) = b + 1 + if b > a then 6 
                           else if b == a then 3
                                else 0
check = ev . c . words 

main = do
    print $ check "C Z"
    fmap (sum . map check . lines) $ readFile "input" -- "small.txt"
