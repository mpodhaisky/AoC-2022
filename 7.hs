data Directory = Dir String [Directory] | File String Int deriving Show
data Cxt = Top | Direction Int Cxt String [Directory] deriving Show
type Loc = (Directory, Cxt)

solution = Dir "myDir" [Dir "/" []]

top t = (t, Top)

moveDown n (Dir name ts, c) = (ts!!n, Direction n c name (take n ts++drop (n+1) ts))

insertAt n 0 xs = n:xs
insertAt n i (x:xs) = x : insertAt n (i - 1) xs

moveUp (t, Direction n c name ts) = (Dir name (insertAt t n ts), c)

dirSum (File _ n) = n
dirSum (Dir _ ds) = sum (map dirSum ds)

total (File _ n) = 0
total d@(Dir _ ds) = if dirSum d <=100000 then dirSum d + sum (map total ds) else sum (map total ds)

spaceNeeded t = 30000000- (70000000 -dirSum t)

remove:: Directory->Int->Int
remove (File _ ds) n = 70000000
remove d@(Dir _ ds) n = if dirSum d>=n then  min (dirSum d) (minimum (map (`remove` n) ds )) else 70000000


moveToTop (t, Top) = t
moveToTop (t, c) = moveToTop (moveUp (t,c))

readInt:: String -> Int
readInt = read


parse (["dir" ,b]:xs) (Dir name ds, c)=  parse xs (Dir name ((Dir b []):ds),c)
parse (["$", "ls"]:xs) l = parse xs l
parse ([a,b]:xs) (Dir name ds, c) = parse xs (Dir name ((File b (readInt a)):ds),c)
parse (["$","cd",".."]:xs) l = parse xs (moveUp l)
parse (["$","cd",a]:xs) l@(Dir name ds, c) = parse xs (moveDown (go a ds 0) l)
    where
        go a ((Dir name ds):xs) i=if a==name then i else go a xs (i+1)
        go a (_:xs) i = go a xs (i+1)

parse (_:xs) l = parse xs l
parse [] l = l

main = do
    input <- readFile "7.txt"
    print .total.moveToTop.(`parse` (solution,Top)).map words.lines $ input
    print .(`remove` 3313415).moveToTop.(`parse` (solution,Top)).map words.lines $ input