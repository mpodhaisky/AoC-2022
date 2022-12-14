import Data.Array
import Data.Maybe (catMaybes)
import Data.Char (ord)

type K = (Int, Int)
infty = maxBound :: Int

grid nx ny ij@(i,j) = catMaybes $  [if i>0  then Just (i-1,j) else Nothing ] 
                                ++ [if i<nx then Just (i+1,j) else Nothing ]
                                ++ [if j>0  then Just (i,j-1) else Nothing ]
                                ++ [if j<ny then Just (i,j+1) else Nothing ]
                                
process = map (map (flip (-) (ord 'a'). ord)) 
small1 = process $ words "aabqponm\nabcryxxl\naccszzxk\nacctuvwj\nabdefghi"    

m1 = array ((0,0),(4,7)) [((i,j),small1!!i!!j) | i<-[0..4], j<-[0..7]]

adj1 ij =  [ y | y<- grid 4 7 ij, m1!ij + 1 >= m1!y]

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

small = let start' = (0,0)
            finish' = (2,5)
            queue' = [start']
            dist = array (bounds m1) [(ij,infty) | ij <- indices m1] // [(start',0)]  
        in S start' finish' queue' dist adj1 False

oneStep :: S -> S
oneStep z = if length (queue z) == 0 then z 
               else let
                        x = head (queue z)
                        ys = [y | y<-adj z x, dist z!y == infty]
                        dist' = dist z // [(y, 1 + dist z! x) | y <- ys]
                        hasFound  = dist z ! finish z <infty
                    in z { queue = tail (queue z) ++ ys,  dist = dist', found = hasFound}

runbfs = until found oneStep 
test2 = dist (runbfs small)!(finish small)                 

main = do
    large1 <- fmap (process . words) $ readFile "input1.txt"
    let m2 = array ((0,0),(40,131)) [((i,j),large1!!i!!j) | i<-[0..40], j<-[0..131]]
    let adj2 ij =  [ y | y<- grid 40 131 ij, m2!ij + 1 >= m2!y]
    let large = let 
                  start' = (20,0)
                  finish' = (20,107)
                  queue' = [start']
                  dist' = array (bounds m2) [(ij, infty) | ij<-indices m2] // [(start',0)]
                 in S start' finish' queue' dist' adj2 False
    print $ ( dist (runbfs large)) ! (finish large)
