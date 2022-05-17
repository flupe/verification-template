import Data.InfiniteList
import Data.Nat


main :: IO ()
main = print $ onesList !!! (Suc (Suc (Suc (Suc (Suc (Suc (Zero)))))))
    where
        onesList = InfiniteList {hd = 1, tl = f 1}

f :: Int -> InfiniteList Int
f a = InfiniteList { hd =  a + 1, tl = f (a + 1)}
