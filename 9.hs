import Data.Set(fromList)

type Pos = (Int, Int) 
type Loc = ([Pos], Pos)

parse::[String]->[Pos]
parse [c,n] = let pair = case c of {
        "L" -> (-1,0); "R" -> (1,0); "U" -> (0,1); "D" -> (0,-1);}
    in replicate (read n) pair

move::Pos->Pos->Pos
move (a,b) (c,d) = (a+c,b+d)

f :: Int -> Int -> Int
f x y
    | abs (x-y)==0 =x
    | abs (x-y)==1 =y
    | otherwise =y + (signum (x-y)) 


follow::Loc->Loc->Loc
follow (xs,(a,b)) (_,(c,d)) 
    | max (abs (a-c)) (abs (b-d))<=1 = (xs, (a,b))
    | otherwise = ((f a c,f b d):xs,(f a c,f b d))

pack (a,b) = ([],(a,b)) ::Loc

-- unpack (xs, _) = xs ::[Pos]   --> (fst, snd) = Standard-Prelude

solver = reverse . fst .last.scanl follow ([(0,0)],(0,0)) .map pack

main = do
    input <- readFile "9test.txt"
    input1 <- readFile "9.txt"
    input2 <- readFile "9test2.txt"
    let testmoves = solver .scanl move (0,0).concatMap (parse.words). lines $ input
    let moves = solver .scanl move (0,0).concatMap (parse.words). lines $ input1
    let test2moves = solver .scanl move (0,0).concatMap (parse.words). lines $ input2
    print.length.fromList$testmoves
    print.length.fromList$moves
    print .length.fromList.last.(take 9). iterate solver $ test2moves
    print .length.fromList.last.(take 9). iterate solver $ moves
