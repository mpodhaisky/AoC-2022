import Data.Set (fromList) 
import Control.Monad (zipWithM) 

type Pos = (Int, Int)   -- ein Feld (x,y)
type Move = (Int, Int)  -- eine Richtung (dx, dy)
type Schlange = [Pos]   -- die Segmente als Felder
type Moves = [Move]     -- eine Folge von Richtungen

-- Segment (c,d) folgt Segment (a,b)
follow :: Pos -> Pos -> Pos
follow (a,b) (c,d) = if max (abs (a-c)) (abs (b-d)) <= 1 
                         then (c,d)
                         else (f a c, f b d)
            where f x y = y + (signum (x-y))

move1step :: Schlange -> Move -> Schlange
move1step ((x,y):snake) (dx,dy) = scanl follow (x+dx, y+dy) snake

parse :: String -> Moves
parse (move:n) =  let dir = case move of { 
                      'L' -> (-1,0) ; 'R' -> (1,0) ; 'U' -> (0,1) ; 'D' -> (0,-1) }
                   in replicate (read n) dir

-- durch das fromList hat man alle Felder nur einmal
moveAndCount :: Schlange -> Moves -> Int
moveAndCount schlange = length . fromList . map last . scanl move1step schlange 

kurzeSchlange = replicate 2 (0,0)  :: Schlange
langeSchlange = replicate 10 (0,0) :: Schlange

test1 = concatMap parse ["R 4", "U 4"]       :: Moves
test2 = move1step [(0,0),(0,0)] (1,0)        :: Schlange
test3 = foldl move1step kurzeSchlange test1
test4 = foldl move1step langeSchlange test1

main = zipWithM run [kurzeSchlange, langeSchlange, langeSchlange] 
                    ["small.txt", "medium.txt", "input"]
       where run schlange fn = fmap (moveAndCount schlange . concatMap parse . lines) 
                                  $ readFile fn
   
