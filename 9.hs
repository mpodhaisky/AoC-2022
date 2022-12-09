import Data.List

type Pos = (Int, Int) 
type Loc = ([Pos], Pos)

parse ["L", n] = [(-1,0) |i<-[1..readInt n]]
parse ["R", n] = [(1,0) |i<-[1..readInt n]]
parse ["U", n] = [(0,1) |i<-[1..readInt n]]
parse ["D", n] = [(0,-1) |i<-[1..readInt n]]

move (a,b) (c,d) = (a+c,b+d)

move' (xs,(a,b)) (_,(c,d))
    | abs (c-a)==2 && abs (d-b)==0 = ((a+ (c-a)`div`2,b):xs,(a+ (c-a)`div`2,b))
    | abs (c-a)==0 && abs (d-b)==2 = ((a,b+ (d-b)`div`2):xs,(a,b+ (d-b)`div`2))
    | abs (c-a)==2 && abs (d-b)==1 = ((a+ (c-a)`div`2,d):xs,(a+ (c-a)`div`2,d))
    | abs (c-a)==1 && abs (d-b)==2 = ((c,b+ (d-b)`div`2):xs,(c,b+ (d-b)`div`2))
    | abs (c-a)==2 && abs (d-b)==2 = ((a+ (c-a)`div`2,b+ (d-b)`div`2):xs,(a+ (c-a)`div`2,b+ (d-b)`div`2))
    | otherwise = (xs, (a,b))

pack (a,b) = ([],(a,b)) ::Loc
spew (xs,_) = length (nub xs)
unpack (xs, _) = xs

readInt:: String -> Int
readInt = read

solver = reverse.unpack .last.scanl move' ([(0,0)],(0,0)) .map pack

main = do
    input <- readFile "9test.txt"
    input1 <- readFile "9.txt"
    input2 <- readFile "9test2.txt"
    let testmoves = solver .scanl move (0,0).concat.map (parse.words). lines $ input
    let moves1 = solver .scanl move (0,0).concat.map (parse.words). lines $ input1
    let moves2 = solver moves1
    let moves3 = solver moves2
    let moves4 = solver moves3
    let moves5 = solver moves4
    let moves6 = solver moves5
    let moves7 = solver moves6
    let moves8 = solver moves7
    let moves9 = solver moves8
    let moves10 = solver moves9
    print .length.nub$moves9
    
