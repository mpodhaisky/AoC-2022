import Data.List.Split (splitOn)
import Data.List (sort)

maxSum =  maximum . map (sum . map read) . splitOn [""] . lines
maxSum2=  sum . take 3 . reverse . sort . map (sum . map read) . splitOn [""] . lines

part1 = fmap   maxSum  $ readFile "input.txt" 

part2 = fmap maxSum2 $ readFile "input.txt"
