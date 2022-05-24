module Data.Nat where

data Nat : Set where
    Zero : Nat
    Suc : Nat -> Nat
{-# COMPILE AGDA2HS Nat #-}

_+++_ : Nat → Nat → Nat
Zero +++ Zero = Zero
Zero +++ Suc b = Suc b
Suc a +++ Zero = Suc a
Suc a +++ Suc b = a +++ Suc(Suc b)
{-# COMPILE AGDA2HS _+++_ #-}