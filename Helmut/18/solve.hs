import Data.List.Split (splitOn)
import qualified Data.Set as S

type P = (Int, Int, Int)
type PS = S.Set P
rd :: String -> P
rd s = read $ "(" ++ s ++ ")" 

hex (x,y,z) = [(x+1,y,z), (x-1,y,z), (x,y+1,z), (x,y-1,z),
    (x,y,z+1),(x,y,z-1)]

bd = 22

faces cubes = 
    [(c,d) | c<- S.toList cubes, d <- hex c, S.member d cubes]

ok (x,y,z) = (all (>=0) [x,y,z]) && (all (<=bd) [x,y,z])

expand :: PS -> PS -> PS
expand cubes water  = 
    S.union water $ S.fromList [c |  w <- (S.toList water) , c <- hex w, 
                 not (S.member c cubes) && (ok c)]

fixedpoint phi x = let y = phi x
                   in if y == x then x 
                      else fixedpoint phi y

outerFaces :: PS -> PS -> Int
outerFaces cubes water = length $ S.fromList [(w,c) | w<- (S.toList water),
    c <- hex w, (S.member c cubes)]


fn = "input2.txt"
main = do
    cubes <- fmap (S.fromList . map rd . lines) $ readFile fn
    let  n = length cubes
    let m = length $ faces cubes
    print $ 6*n - m
    let water = S.singleton (0,0,0)
    print $  outerFaces cubes $ fixedpoint (expand cubes) water
