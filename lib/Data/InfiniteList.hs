module Data.InfiniteList where

import Data.Nat

data InfiniteList a = InfiniteList{hd :: a, tl :: InfiniteList a}

headOfInf :: InfiniteList a -> a
headOfInf e = hd e

(!!!) :: InfiniteList a -> Nat -> a
list !!! Zero = hd list
list !!! Suc n = tl list !!! n

