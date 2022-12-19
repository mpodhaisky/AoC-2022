import System.IO.Unsafe (unsafePerformIO)

small :: String
small = unsafePerformIO $ readFile "small.txt"
