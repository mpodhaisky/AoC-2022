import Data.Array

dd = [(0,1),(1,0),(0,-1),(-1,0)]

n = 99

inBoard (i,j) = (0<=i) && (i<n) && (0<=j) && (j<n)

sec dx dy i j = takeWhile inBoard [(i+l*dx, j+l*dy) | l<-[1..]]

view a dx dy i j =  takeWhile 
                      

main = do 
    img <- fmap (lines) $ readFile "input"
    let a = array ((0,0),(n-1, n-1)) [((i,j),img!!i!!j) | j<-[0..n-1], i<-[0..n-1]]
    print a
    