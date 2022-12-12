type Knot = (Int,Int,Int)
type Edge = (Knot,[Knot])
type Path = (Knot,Knot)

packer c = (fromEnum c-97,1,1)

addx (_,a,_) (c,x,y) = (c,x+a,y)
addy (_,_,a) (c,x,y) = (c,x,y+a)

isStart (-14,_,_) = True
isStart _ = False
isEnd (-28,_,_) = True
isEnd _ = False

setn n (_,x,y) = (n,x,y)

isChildOf (n,x,y) (m,a,b) = abs (x-a)<=1 && abs (y-b)<=1 && abs (n-m)<=1 && not (x==a&&y==b)

childrenOf knot knots = (knot,filter (isChildOf knot) knots)

makePath a b = (a,b)

dijkstra::Edge->[Edge]->[Path]->[Path]
dijkstra (from, to) edges paths = paths++newPaths
    where newPaths =(map (makePath from) to)

main = do
    input <- readFile "12.txt"
    let knots = concat. scanl1 (zipWith addy).map (scanl1 addx.map packer). lines $ input
    let start = setn 0.head $ filter isStart knots
    let end = setn 26 .head $ filter isEnd knots
    let knots' = start:end:(filter (not .isEnd).filter (not .isStart) $knots)
    let edges =map (`childrenOf` knots') knots'

    print edges
    print $ dijkstra (head edges) edges []
