data Monkey = Monkey { xs :: [Int] , f  :: Int -> Int , to :: Int -> Int } 

m0 = Monkey [79, 98]  (*19)  (\x->(if mod x 23 == 0 then 2 else 3))
m1 = Monkey [54,65,75,74]  (+6)  (\x->(if mod x 19 == 0 then 2 else 0))
m2 = Monkey [79, 60, 97] (^2) (\x->(if mod x 13 == 0 then 1 else 3))
m3 = Monkey [74] (+3) (\x -> (if mod x 17 == 0 then 0 else 1))

give monkey item = Monkey (xs monkey ++ [item]) (f monkey) (to monkey)

inpect :: Monkey -> (Monkey, Int, Int)
inspect m = let 
             item = head (xs m)
	    in (Monkey (tail $ xs m) (f m) (to m)), (to $ (f item) `div` 3)

instance Show Monkey  where
    show (Monkey xs f to ) = show xs

test1 = give m0 17

{--
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1

--}
