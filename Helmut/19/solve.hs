import System.IO.Unsafe (unsafePerformIO)
import Data.List.Split (splitOn)

data C = Ore Int| Clay Int | Obsidian Int | Geode Int
    deriving (Show, Eq)


b1 = [[Ore 4], [Ore 3], [Ore 3, Clay 14], [Ore 2, Obsidian 7]]
b2 = [[Ore 2], [Ore 3], [Ore 3,  Clay 8], [Ore 3, Obsidian 12]]

robots = [Ore 1]