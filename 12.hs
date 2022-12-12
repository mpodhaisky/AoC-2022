readInt:: String -> Int
readInt = read

packer c = (fromEnum c-97,1,1)

addx (_,a,_) (c,x,y) = (c,x+a,y)
addy (_,_,a) (c,x,y) = (c,x,y+a)

startEnd (-14,_,_) = True
startEnd (-28,_,_) = True
startEnd _ = False

setn n (_,x,y) = (n,x,y)

getChildren (n,x,y) (m,a,b) = abs (x-a)<=1 && abs (y-b)<=1 && abs (n-m)<=1 && not (x==a&&y==b)

remove [] ys = ys
remove (x:xs) ys = remove xs (filter (/=x) ys)

dfs:: [(Int,Int,Int)]->(Int,Int,Int) ->(Int,Int,Int) ->Int
dfs heightmap endpoint r@(n,x,y) = if (children/=[]) then 1+minimum (map (dfs (filter (/=r) (remove children heightmap)) endpoint) children) else if r==endpoint then 1 else 1000000
    where
        children = filter (getChildren r) heightmap

main = do
    input <- readFile "12.txt"
    let heightmap = concat. scanl1 (zipWith addy).map (scanl1 addx.map packer). lines $ input
    let start = setn 0.head $ filter (startEnd) heightmap
    let end = setn 25.last $ filter (startEnd) heightmap
    print start
    print end
    print $ dfs heightmap end start
