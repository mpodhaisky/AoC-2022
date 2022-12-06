import Data.List.Split (splitOn)

maxSum =  maximum . map (sum . map read) . splitOn [""] . lines

main = fmap maxSum $ readFile "input"
