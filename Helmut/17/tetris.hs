import qualified Data.Set as S
import Data.List (intercalate)
import System.IO.Unsafe (unsafePerformIO)

type P = (Int, Int)

ps :: [S.Set P]
ps = map S.fromList [[(0,0),(1,0),(2,0),(3,0)]
    , [(1,0),(0,1),(1,1),(2,1),(1,2)]
    , [(0,0),(1,0),(2,0),(2,1),(2,2)]
    , [(0,0),(0,1),(0,2),(0,3)]
    , [(0,0),(1,0),(0,1),(1,1)]
     ]

flow1 = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

data Board = Board {
       b    :: S.Set P 
    , flow  :: String
    , next  :: Int
    , numberPieces :: Int
    , hover :: S.Set P
} 

height :: Board -> Int
height  = (1+) . S.fold max 0 . S.map snd . b 

instance Show Board where 
    show z = let
                top = S.fold max 0 $ S.map snd $ hover z
                c ij = if S.member ij (hover z) then '@'
                       else if S.member ij (b z) then '#'
                       else '.'
                picture = intercalate "\n" [[c (j,i) | i<-[top,top-1..top-80] ] | j<- [6,5..0]]
             in [head (flow z)] ++ " " ++ show (numberPieces z) ++ "\n" ++ picture ++"\n"

add (dx,dy) (x,y) = (x + dx,y+dy)

step :: Board -> Board
step z = let
            xx = S.map fst (hover z)
            aa = S.fold min 6 xx
            bb = S.fold max 0 xx
            yy = S.fold min 10 $ S.map snd (hover z)
            top = S.fold max 0 $ S.map snd $ S.union (b z) (hover z) :: Int
            (c:_) = flow z
            dx = if c == '>' && bb<6 then 1
                 else if c == '<' && aa>0 then -1
                 else 0
            p1 = S.map (add (dx,0)) (hover z)
            p2 = if S.null (S.intersection p1 (b z)) then p1
                                                     else hover z
            p3 = S.map (add (0,-1)) p2
            downcollide = not $ S.null $ S.intersection p3 (b z)
            stuck = (yy == 0) || downcollide
            p4 = if stuck then p2
                          else p3
            newb = if stuck then S.union (b z) p4
                            else b z

            nn = mod ((next z) + 1) 5
            nextp = ps !! nn :: S.Set P
            nh =  if stuck then S.map (add (2, 4+top)) nextp
                           else p4
         in z {b = newb
             , hover = nh
             , flow = tail (flow z)
             , next = if stuck then nn
                               else next z
             , numberPieces = if stuck then numberPieces z + 1
                                       else numberPieces z 
              }

genBoard fl = 
     Board {
        b = S.empty
        , flow = cycle fl
        , next = 0
        , numberPieces = 0
        , hover = S.map (add (2,3)) $ head ps
        }

b0 = genBoard flow1 
b1 = genBoard (unsafePerformIO $ readFile "input.txt")

demo = height $ until ( (== 2022). numberPieces)  step b0
part1 = height $ until ( (== 2022). numberPieces)  step b1