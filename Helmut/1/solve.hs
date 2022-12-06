import Data.List.Split (splitOn)

main = do
    w <- fmap lines $ readFile "input"
    print $  maximum $ map (sum . map read) $ splitOn [""] w
