module Data.InfiniteList where

import Data.Nat

data InfiniteList a = InfiniteList{hd :: a, tl :: InfiniteList a}

hdInf :: InfiniteList a -> a
hdInf list = hd list

tlInf :: InfiniteList a -> InfiniteList a
tlInf list = tl list

(!!!) :: InfiniteList a -> Nat -> a
list !!! Zero = hdInf list
list !!! Suc n = tlInf list !!! n

takeInf :: Nat -> InfiniteList a -> [a]
takeInf Zero list = []
takeInf (Suc n) list = hdInf list : takeInf n (tlInf list)

dropInf :: Nat -> InfiniteList a -> InfiniteList a
dropInf Zero list = list
dropInf (Suc n) list = dropInf n (tlInf list)

