import Data.Set(fromList)

type Pos = (Int, Int) 
type Loc = ([Pos], Pos)

parse::[String]->[Pos]
parse [c,n] = case c of
    "L" -> [(-1,0) |i<-[1..m]]
    "R" -> [(1,0) |i<-[1..m]]
    "U" -> [(0,1) |i<-[1..m]]
    "D" -> [(0,-1) |i<-[1..m]]
    where m = read n

move::Pos->Pos->Pos
move (a,b) (c,d) = (a+c,b+d)

f :: Int -> Int -> Int
f x y = y + (signum (x-y))

follow::Loc->Loc->Loc
follow (xs,(a,b)) (_,(c,d))
    | abs (c-a)==2 && abs (d-b)==0 = ((f a c,b):xs,(f a c,b))
    | abs (c-a)==2 && abs (d-b)==1 = ((f a c,d):xs,(f a c,d))
    | abs (c-a)==2 && abs (d-b)==2 = ((f a c,f d b):xs,(f a c,f d b))
    | abs (c-a)==0 && abs (d-b)==2 = ((a,f d b):xs,(a,f d b))
    | abs (c-a)==1 && abs (d-b)==2 = ((c,f d b):xs,(c,f d b))
    | otherwise = (xs, (a,b))

pack (a,b) = ([],(a,b)) ::Loc

unpack (xs, _) = xs ::[Pos]

solver = reverse.unpack .last.scanl follow ([(0,0)],(0,0)) .map pack

main = do
    input <- readFile "9test.txt"
    input1 <- readFile "9.txt"
    input2 <- readFile "9test2.txt"
    let testmoves = solver .scanl move (0,0).concat.map (parse.words). lines $ input
    let moves = solver .scanl move (0,0).concat.map (parse.words). lines $ input1
    let test2moves = solver .scanl move (0,0).concat.map (parse.words). lines $ input2
    print.length.fromList$testmoves
    print.length.fromList$moves
    print .length.fromList.last.(take 9). iterate solver $ test2moves
    print .length.fromList.last.(take 9). iterate solver $ moves
    
