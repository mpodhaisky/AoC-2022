import Data.List.Split (splitOn)
import Data.List (sort)

maxSum =  sum . take 3 . reverse . sort . map (sum . map read) . splitOn [""] . lines

main = fmap maxSum $ readFile "input"
