import Data.List (intercalate) 

data T = L Int | K [T] deriving (Eq)

t1 = K [L 1, L 1, L 3, L 1, L 1]
t2 = K [L 1, L 1, L 5, L 1, L 1]

t3 = K [ K [L 1], K [L 2, L 3, L 4]]
t4 = K [ K [L 1], L 4]

instance Show T where
  show (L a) = show a
  show (K xs) = "[" ++  
                    ( intercalate ","
                     $ map show xs )
                  ++ "]"

instance Ord T where 
  (L x) <= (L y)  = x <= y
  (L x) <= (K ys) = (K [L x]) <= (K ys)
  (K xs) <= (L y) = (K xs) <= (K [L y])
  (K (x:_)) <= (K []) = False
  (K []) <= (K (y:ys)) = True
  (K []) <= (K []) = True
  (K (x:xs)) <= (K (y:ys)) = (x<y) || ((x == y) && ((K xs) <= (K ys)))

-- pr :: String -> T
--
test1 = t3 <= t4
