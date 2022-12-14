import Data.List.Split (splitOn)
import qualified Data.Set as Set

small = "498,4 -> 498,6 -> 496,6\n503,4 -> 502,4 -> 502,9 -> 494,9"

type P = (Int, Int)
type Grid = Set.Set P

pairs [a,b] = (a,b)

read2 :: String -> (Int, Int)
read2 = pairs . map read . splitOn "," 


add2 (x,y) (u,v) = (x+u, y+v)

connect2points xy@(x,y) uv@(u,v) = let dx = signum (u-x); dy = signum (v-y)
                      in (uv:) $ takeWhile (/=uv) $ iterate (add2 (dx, dy)) xy

connect :: [P] -> [P]
connect ps = concatMap (uncurry connect2points) $ zip ps (tail ps)

filled :: String -> Grid
filled txt = Set.fromList $ concatMap (connect . map read2 . splitOn "->") $ lines txt    

sift :: Grid -> (P, Bool) -> (P, Bool)
sift grid (xy, stuck) = let
                     south = add2 xy (0,1)          
                     sw = add2 xy (-1,1)
                     se = add2 xy (1,1)
                     xy' = head $ dropWhile (\p -> Set.member p grid) [south, sw, se, xy]
                    in (xy', xy'==xy)

addOne :: (Grid, Bool) -> (Grid, Bool)
addOne (grid,_) = let   
                  k = maximum $ Set.map snd grid
                  (xy@(x,y), stuck) = until  (\(xy@(x,y), stuck)-> stuck || y > k) (sift grid) ((500,0), False)
               in if stuck then (Set.insert xy grid, stuck)
                             else (grid, stuck)

main = do 
    grid <- fmap filled (readFile "input.txt")
    let grid' = fst $ until (not.snd) addOne (grid, True)
    print $ length grid' - length grid
