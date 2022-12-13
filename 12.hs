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

isChildOf (n,x,y) (m,a,b) = abs (x-a)<=1 && abs (y-b)<=1 && m-n<=1 && not (abs(x-a)==abs(y-b))

childrenOf knot knots = (knot,filter (isChildOf knot) knots)

makePath a b = (a,b)

delete [] ys = ys
delete (x:xs) ys = delete xs (filter (/=x) ys)

removeUnveiled xs (from,to) = (from, delete xs to)

getEdge knot edges = head $ filter ((==knot).fst) edges

bfs::Edge->[Edge]->[Knot]->[Path]->[Path]
bfs current@(from, to) edges q paths= if (q++to)==[] then paths else bfs (getEdge (head (q++to)) edges') edges' (tail (q++to)) (paths++newPaths)
    where 
        newPaths =(map (makePath from) to)
        edges' =map (removeUnveiled (from:to)) (filter (/=current) edges)

dfs paths start= if children==[] then 0 else 1+ maximum(map (dfs paths) children)
    where
        children = map snd (filter ((==start).fst) paths)

main = do
    input <- readFile "12.txt"
    let knots = concat. scanl1 (zipWith addy).map (scanl1 addx.map packer). lines $ input
    let start = setn 0.head $ filter isStart knots
    let end = setn 26 .head $ filter isEnd knots
    let knots' = start:end:(filter (not .isEnd).filter (not .isStart) $knots)
    let edges =map (`childrenOf` knots') knots'
    let paths = bfs (head edges) edges [] []
    let tmp = takeWhile ((/=end).snd) paths
    
    print .(+1)$ dfs tmp start
