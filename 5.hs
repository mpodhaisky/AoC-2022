readInt::String->Int
readInt = read

moveCrate:: [String]->[Int]->[String]
moveCrate cs [a,b,c] = [if i == b then drop a (cs !!(i-1)) else if i==c then (reverse (take a (cs !! (b-1)))++(cs!!(c-1))) else cs !! (i-1) |i <-[1..(length cs)]]

moveMulti:: [String]->[Int]->[String]
moveMulti cs [a,b,c] = [if i == b then drop a (cs !!(i-1)) else if i==c then (take a (cs !! (b-1)))++(cs!!(c-1)) else cs !! (i-1) |i <-[1..(length cs)]]

reapply _ c [] = c
reapply f c (x:xs) = reapply f (f c x) xs

main = do
    input <- readFile "5.txt"
    input1 <- readFile "5test.txt"
    let crates = take 9 .lines $ input
    let rules = drop 9 . map (map readInt.words).lines $ input

    let crates1 = take 3 .lines $ input1
    let rules1 = drop 3 . map (map readInt.words).lines $ input1

    print .map head$reapply moveCrate crates rules
    print .map head$ reapply moveCrate crates1 rules1

    print .map head$reapply moveMulti crates rules
    print .map head$ reapply moveMulti crates1 rules1