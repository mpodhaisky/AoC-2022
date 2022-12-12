import Data.Array
import Data.Maybe (catMaybes)
import Data.Char (ord)

type K = (Int, Int)
infty = 10000

grid nx ny ij@(i,j) = catMaybes $  [if i>0  then Just (i-1,j) else Nothing ] 
                                ++ [if i<nx then Just (i+1,j) else Nothing ]
                                ++ [if j>0  then Just (i,j-1) else Nothing ]
                                ++ [if j<ny then Just (i,j+1) else Nothing ]
                                

small1 = map (map (flip (-) (ord 'a'). ord)) $ words "Sabqponm\nabcryxxl\naccszExk\nacctuvwj\nabdefghi"    

m1 = array ((0,0),(4,7)) [((i,j),small1!!i!!j) | i<-[0..4], j<-[0..7]]

adj1 ij =  [ y | y<- grid 4 7 ij, (m1!y == -28) || (m1!ij + 1 >= m1!y) || (m1!ij == -14 && m1!y <= 1)]

data S = S { 
      start  ::  K
    , finish ::  K
    , queue  :: [K]
    , dist   :: Array K Int
    , adj    :: K -> [K]
    , found  :: Bool
}

instance Show S  where
    show z = show (queue z) ++ "\n" ++ (show $ elems $ dist z) ++ (show $ found z)

locate m c = fst  $ head $ filter ((==c).snd) (assocs m) 

small = let 
            s = locate m1 (ord 'S' - ord 'a')
            f = locate m1 (ord 'E' - ord 'a')
            q = [s]
            dist = array (bounds m1) [(ij,infty) | ij <- indices m1] // [(s,0)]  
         in S s f q dist adj1 False


oneStep :: S -> S
oneStep z = if length (queue z) == 0 || (found z) 
                 then z 
                 else let
                          x = head (queue z)
                          queue' = tail (queue z) ++ ys
                          ys = [y | y<-adj z x, dist z!y == infty]
                          dist' = dist z // [(y, 1 + dist z! x) | y <- ys]
                          finish' = dist z ! finish z <infty
                      in S (start z) (finish z) queue' dist' (adj z) finish'

test1 = head $ dropWhile (\z -> not $ found z) $ iterate oneStep small     
test2 = dist test1!(finish small)                 

