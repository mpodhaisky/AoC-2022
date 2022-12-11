import Data.Array
import Data.List (sort)

data Monkey = Monkey { xs :: [Int] , f  :: Int -> Int , to :: Int -> Int }

m0 = Monkey [79, 98]  (*19)  (\x->(if mod x 23 == 0 then 2 else 3))
m1 = Monkey [54,65,75,74]  (+6)  (\x->(if mod x 19 == 0 then 2 else 0))
m2 = Monkey [79, 60, 97] (^2) (\x->(if mod x 13 == 0 then 1 else 3))
m3 = Monkey [74] (+3) (\x -> (if mod x 17 == 0 then 0 else 1))

give monkey item = Monkey (xs monkey ++ [item]) (f monkey) (to monkey)

data GroupOfMonkeys = GroupOfMonkeys {
     ms :: Array Int Monkey 
   , ni :: Array Int Int -- number of inspections
 } deriving (Show)

grp = GroupOfMonkeys  (array (0,3) $ zip [0..] [m0,m1,m2,m3]) (array (0,3) $ zip [0..] [0,0,0,0])

turn :: Int -> GroupOfMonkeys  -> GroupOfMonkeys
turn i grp = let
    mi = ms grp ! i
    (mi', y, j) = inspect mi
    mj = ms grp ! j
    mj' = Monkey (xs mj ++ [y]) (f mj) (to mj)
    ni'  = ni grp ! i 
    in GroupOfMonkeys (ms grp // [(i, mi'), (j, mj')]) (ni grp // [(i, ni' +1 )])

move i grp = if length (xs (ms grp ! i)) == 0 then grp
                                              else move i (turn i grp)

runde grp = foldl (flip move) grp [0..snd $ bounds $ ms grp]

applyN = (foldr (.) id.) . replicate

inspect :: Monkey -> (Monkey, Int, Int)
inspect m = let 
             x = head (xs m) :: Int
             y = div (f m x) 3 :: Int
             receiver = (to m) y 
      in (Monkey (tail $ xs m) (f m) (to m), y, receiver)

instance Show Monkey  where
    show (Monkey xs f to ) = show xs

test1 = inspect m0
test2  = give m3 500
test3 = turn 0 grp
test4 = applyN 20 runde grp
test5 = foldl1 (*) $ take 2 $ reverse $ sort $ elems $ ni test4

