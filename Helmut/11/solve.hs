import Data.Array
import Data.List (sort)

data Monkey = Monkey { xs :: [Int] , f  :: Int -> Int , to :: Int -> Int }

data GroupOfMonkeys = GroupOfMonkeys {
     ms :: Array Int Monkey 
   , ni :: Array Int Int -- number of inspections 
   } deriving (Show)

check p a b x = if mod x p == 0 then a else b

-- small set
m0 = Monkey [79, 98]  (*19)      (check 23 2 3)
m1 = Monkey [54,65,75,74]  (+6)  (check 19 2 0)
m2 = Monkey [79, 60, 97] (^2)    (check 13 1 3)
m3 = Monkey [74] (+3)            (check 17 0 1) 

smallg = GroupOfMonkeys  (array (0,3) $ zip [0..] [m0,m1,m2,m3]) 
                         (array (0,3) $ zip [0..] [0,0,0,0])
--
-- larger input set 
a0 = Monkey [80] (*5)                             (check 2 4 3)
a1 = Monkey [75,83,74] (+7)                       (check 7 5 6) 
a2 = Monkey [86, 67, 61, 96, 52, 63, 73] (+5)     (check 3 7 0)
a3 = Monkey [85, 83, 55, 85, 57, 70, 85, 52] (+8) (check 17 1 5)
a4 = Monkey [7, 75, 91, 72, 89] (+4)              (check 11 3 1)
a5 = Monkey [66, 64, 68, 92, 68, 77] (*2)         (check 19 6 2)
a6 = Monkey [97, 94, 79, 88] (^2)                 (check 5 2 7)
a7 = Monkey [77,85]          (+6)                 (check 13 4 0)

give monkey item = Monkey (xs monkey ++ [item]) (f monkey) (to monkey)

largeg = GroupOfMonkeys  (array (0,7) 
                             $ zip [0..] [a0,a1,a2,a3,a4,a5,a6,a7]) 
                         (array (0,7) $ zip [0..] (replicate 8 0))

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

auswertung = foldl1 (*) . take 2 . reverse . sort . elems . ni 

test1 = inspect m0
test2  = give m3 500
test3 = turn 0 smallg
test4 = applyN 20 runde smallg
demo = auswertung test4
part1 = auswertung $ applyN 20 runde largeg 
