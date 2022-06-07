module Data.InfiniteList where

import Data.Nat

data InfiniteList a = InfiniteList{hd :: a, tl :: InfiniteList a}

infNatList :: Nat -> InfiniteList Nat
infNatList n Data.InfiniteList.InfiniteList.hd = n
infNatList n Data.InfiniteList.InfiniteList.tl = infNatList (Suc n)

repeatInf :: a -> InfiniteList a
repeatInf x Data.InfiniteList.InfiniteList.hd = x
repeatInf x Data.InfiniteList.InfiniteList.tl = repeatInf x

fibonacci :: Nat -> Nat -> InfiniteList Nat
fibonacci n1 n2 Data.InfiniteList.InfiniteList.hd = n1
fibonacci n1 n2 Data.InfiniteList.InfiniteList.tl
  = fibonacci n2 (n1 +++ n2)

hdInf :: InfiniteList a -> a
hdInf list = hd list

tlInf :: InfiniteList a -> InfiniteList a
tlInf list = tl list

(!!!) :: InfiniteList a -> Nat -> a
list !!! Zero = hdInf list
list !!! Suc n = tlInf list !!! n

takeInf :: InfiniteList a -> Nat -> [a]
takeInf list Zero = []
takeInf list (Suc n) = hdInf list : takeInf (tlInf list) n

dropInf :: InfiniteList a -> Nat -> InfiniteList a
dropInf list Zero = list
dropInf list (Suc n) = dropInf (tlInf list) n

even :: InfiniteList a -> InfiniteList a
even xs Data.InfiniteList.InfiniteList.hd = hd xs
even xs Data.InfiniteList.InfiniteList.tl = even (tl (tl xs))

odd :: InfiniteList a -> InfiniteList a
odd xs = even (tl xs)

split :: InfiniteList a -> (InfiniteList a, InfiniteList a)
split xs = (even xs, odd xs)

merge :: (InfiniteList a, InfiniteList a) -> InfiniteList a
merge (xs, ys) Data.InfiniteList.InfiniteList.hd = hd xs
merge (xs, ys) Data.InfiniteList.InfiniteList.tl
  = merge (ys, tl xs)

