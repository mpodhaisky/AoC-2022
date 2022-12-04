readInt::String->Int
readInt = read

contains [a,b,c,d] = if (a<=c) && (b>=d) || (c<=a) && (d>=b) then 1 else 0

overlap [a,b,c,d] = if (a-c<=0) && (b-c>=0) || (a-d<=0) && (b-d>=0) || contains [a,b,c,d]==1 then 1 else 0 

main = do
    input <- readFile "4.txt"
    input2 <- readFile "4test.txt"
    print .sum.map (contains.map readInt.words) . lines $ input2
    print .sum.map (overlap.map readInt.words) . lines $ input2

    print .sum.map (contains.map readInt.words) . lines $ input
    print .sum.map (overlap.map readInt.words) . lines $ input