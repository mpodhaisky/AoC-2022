data Directory = Dir [Directory] | File Int deriving Show
data Cxt = Top | Direction Int Cxt [Directory]
type Loc = (Directory, Cxt)

test = Dir [Dir [Dir [File 1]]]
top t = (t, Top)

moveDown n (Dir ts, c) = (ts!!n, Direction n c (take n ts++drop (n+1) ts))

insertAt n 0 xs = n:xs
insertAt n i (x:xs) = x : insertAt n (i - 1) xs

moveUp (t, Direction n c ts) = (Dir (insertAt t n ts), c)

dirSum (File n) = n
dirSum (Dir ds) = sum (map dirSum ds)


readInt:: String -> Int
readInt = read


parse [a ,b] = if a =="dir" then Dir [] else if a/="$" then File (readInt a) else Dir []
parse _ = Dir []



con xs = length xs<3

main = do
    input <- readFile "7.txt"
    print . map parse . filter con. map words.lines $ input