import Data.List (unfoldr)
import Data.Tuple

s = "12120-2211===-"


f :: [Integer] -> Integer
f = foldl phi 0 
    where phi z d = 5*z + d

conv xs = map w xs 
    where 
          w '1' = 1
          w '2' = 2
          w '0' = 0
          w '-' = -1
          w '=' = -2


swp (a,b) = (b,a)
ad5 :: Integer -> [Integer]
ad5 = reverse . unfoldr phi 
    where phi 0 = Nothing
          phi x = Just (swap $ divMod x 5)

balance :: [Integer] -> [Integer]
balance xs = finish $ foldr phi ([], 0) xs
    where 
        phi d (rs, c) = 
            let 
                w = d + c
                (dd, cc) = if w > 2 then (w-5,1)
                                    else (w, 0)
            in (dd:rs, cc)
        finish (rr, 0) = rr
        finish (rr, c) = c:rr

testme = f $ balance  $  ad5 12345