
type Monkey = (Int,[Int],[String],Int,Int,Int,Int)
type Gang = [Monkey]


parse::[[String]]->Monkey
parse [a,b,c,d,e,f] = ((read.take 1.last$a),(map (read.filter (/=',')).drop 2$b),drop 3 c,(read.last $d),(read.last$ e),(read.last$ f),0)

function [_,_,"old"] = (^2)
function [_, g, n] = case g of 
    "*"->(*(read n))
    "+"->(+ (read n))

clearMonkey x@(a,b,c,d,e,f,g) y = if x==y then (a,[],c,d,e,f,g) else y

addMonkey (a,xs,b,c,d,e,f) (_,ys,_,_,_,_,_) = (a,xs++ys,b,c,d,e,f)

throw (monkey@(a,[],b,c,d,e,f):xs) =xs++[monkey]
throw (monkey@(a,b,c,d,e,f,g):monkeys)= (zipWith addMonkey (monkeys) (foldl1 (zipWith addMonkey) (map (`update` (monkeys)) (map (eval' d e f.function c) b))))++[(a,[],c,d,e,f,g+length b)]

eval' a b c d= if d `mod`a==0 then (b,d) else (c,d)

update::(Int,Int)->[Monkey]->[Monkey]
update _ [] = []
update (m,n) (monkey@(a,b,c,d,e,f,g):monkeys) =if m==a then (a,[n],c,d,e,f,g):(update (m,n) monkeys) else (a,[],c,d,e,f,g):(update (m,n) monkeys)

breakLines n = map (take n) . takeWhile (/=[]) . iterate (drop n)

eval [] = []
eval ((a,b,c,d,e,f,g):xs) = (a,g):(eval xs)
main = do
    input <- readFile "11test.txt"
    input1 <- readFile "11.txt"
    let monkeys =map (parse.map words).breakLines 6.filter (/="").lines $ input
    let throws = eval.last $ take (4*1000+1) (iterate throw monkeys)
    print throws

