import Data.List (intercalate, sort) 

data T = L Int | K [T] deriving (Eq, Read)

t1 = read "K [L 1, L 1, L 3, L 1, L 1]" :: T
t2 = read "K [L 1, L 1, L 5, L 1, L 1]" :: T

t3 = read "K [ K [L 1], K [L 2, L 3, L 4]]" :: T
t4 = read "K[ K[L 1], L 4]" :: T

extra = [K [ K [ L 2 ]], K [ K [L 6]]]

instance Show T where
  show (L a) = show a
  show (K xs) = "[" ++  ( intercalate "," $ map show xs ) ++ "]"

instance Ord T where 
  (L x)  <= (L y)  = x <= y
  (L x)  <= (K ys) = (K [L x]) <= (K ys)
  (K xs) <= (L y) = (K xs) <= (K [L y])
  (K (x:_)) <= (K []) = False
  (K []) <= (K (y:ys)) = True
  (K []) <= (K []) = True
  (K (x:xs)) <= (K (y:ys)) = (x<y) || ((x == y) && ((K xs) <= (K ys)))

readT = read :: String -> T

test1 = t3 <= t4

pairs :: [String] -> [[String]]
pairs = map (take 2) . takeWhile (/=[]) . iterate (drop 3 ) 

check :: [String] -> Bool
check [a,b] = (readT a) <= (read b)

-- vim %s/\(\d\+\)/L \1/g
--
main = do
    l <- fmap lines $ readFile "input1.txt"
    print $ sum $ map snd $ filter fst $ zip (map check $ pairs l ) [1..]  -- part 1
    let xs = sort $ (++ extra) $ map readT $ filter (/="") l
    print $ foldl1 (*) $ map snd $ filter (\x -> fst x `elem` extra) $ zip xs [1..]
