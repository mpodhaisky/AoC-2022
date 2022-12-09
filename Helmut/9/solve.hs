import Data.List
-- import Data.Set -- später anstelle von nub

f :: Int -> Int -> Int
f x y = y + (signum (x-y))

-- (c,d) folgt (a,b)
follow :: Pos -> Pos -> Pos
follow (a,b) (c,d) = 
    if max (abs (a-c)) (abs (b-d)) <= 1 
      then (c,d)
      else (f a c, f b d)

move1 ((x,y):snake) (dx,dy) = let
   newhead = (x+dx, y+dy)
   in scanl follow newhead snake

type Pos = (Int, Int) 
type Loc = ([Pos], Pos)

parse :: String -> [Pos]
parse (move:n) =  let dir = case move of { 
     'L' -> (-1,0) ; 'R' -> (1,0) ; 'U' -> (0,1) ; 'D' -> (0,1) }
  in replicate (read n) dir

kurzeSchlange = replicate 2 (0,0)
langeSchlange = replicate 10 (0,0)

test1 = concatMap parse ["R 4", "U 4"]
test2 = move1 [(0,0),(0,0)] (1,0)
test3 = foldl move1 kurzeSchlange test1
test4 = foldl move1 langeSchlange test1

