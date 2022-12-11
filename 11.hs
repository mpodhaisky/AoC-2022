
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

clearMonkey x@(a,b,c,d,e,f) y = if x==y then (a,[],c,d,e,f) else y

addMonkey (a,xs,b,c,d,e) (_,ys,_,_,_,_) = (a,xs++ys,b,c,d,e)

throw monkeys monkey@(a,b,c,d,e,f) =map (clearMonkey monkey) (foldl1 (zipWith addMonkey) (breakLines (length monkeys) ((map update (map ( eval' d e f .(`div` 3).function c) b)) <*> monkeys)))

eval' a b c d= if d `mod`a==0 then (b,d) else (c,d)

update::(Int,Int)->Monkey->Monkey
update (m,n) (p,ts,a,b,c,d) =if m==p then (p,([n]),a,b,c,d) else (p,[],a,b,c,d)

breakLines n = map (take n) . takeWhile (/=[]) . iterate (drop n)
main = do
    input <- readFile "11test.txt"
    let monkeys =map (parse.map words).breakLines 6.filter (/="").lines $ input
    let throws =  zipWith addMonkey monkeys (throw monkeys (head monkeys))
    print monkeys
    print throws

-- addMonkey (a,xs,b,c,d,e) (_,ys,_,_,_,_) = (a,xs++ys,b,c,d,e)
-- throw monkeys (a,b,c,d,e,f) =foldl (zipWith addMonkey) monkeys (breakLines (length monkeys) ((map update (map ( eval' d e f .(`div` 3).function c) b)) <*> monkeys))

-- eval' a b c d= if d `mod`a==0 then (b,d) else (c,d)

-- update::(Int,Int)->Monkey->Monkey
-- update (m,n) (p,ts,a,b,c,d) =if m==p then (p,([n]),a,b,c,d) else (p,[],a,b,c,d)