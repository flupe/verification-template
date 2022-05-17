module Data.Nat where

data Nat : Set where
    Zero : Nat
    Suc : Nat -> Nat
{-# COMPILE AGDA2HS Nat #-}
