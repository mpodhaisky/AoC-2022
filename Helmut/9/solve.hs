import Data.List
import Data.Set -- später anstelle von nub


type Pos = (Int, Int) 
type Loc = ([Pos], Pos)

parse :: String -> [Pos]
parse (move:n) =  let dir = case move of { 
     'L' -> (-1,0) ; 'R' -> (1,0) ; 'U' -> (0,1) ; 'D' -> (0,1) }
  in replicate (read n) dir

test1 = concatMap parse ["R 4", "U 4"]
    
