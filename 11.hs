
type Monkey = (Int,[Int],[String],Int,Int,Int)
type Pos = ([Monkey],Monkey)

readInt:: String -> Int
readInt = read

parse::[[String]]->Monkey
parse [a,b,c,d,e,f] = ((read.take 1.last$a),(map (read.filter (/=',')).drop 2$b),drop 3 c,(read.last $d),(read.last$ e),(read.last$ f))



function [_,_,"old"] = (^2)
function [_, g, n] = case g of 
    "*"->(*(read n))
    "+"->(+ (read n))


eval (a,b,c,d,e,f) = map ( eval' d e f .(`div` 3).function c) b 

eval' b c d a= if a `mod`b==0 then (c,a) else (d,a)

breakLines n = map (take n) . takeWhile (/=[]) . iterate (drop n)
main = do
    input <- readFile "11.txt"
    print.map (eval .parse.map words).breakLines 6.filter (/="").lines $ input