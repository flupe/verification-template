{-# OPTIONS --guardedness #-}
module Data.InfiniteList where

open import Data.Nat

record InfiniteList (a : Set) : Set where
    coinductive
    field
        hd : a
        tl : InfiniteList a
{-# COMPILE AGDA2HS InfiniteList #-}

open InfiniteList public

headOfInf  : {a : Set} → InfiniteList a → a
headOfInf e = (hd e)
{-# COMPILE AGDA2HS headOfInf #-} 

_!!!_ : {a : Set} → InfiniteList a → Nat → a
_!!!_ list Zero = (hd list) 
_!!!_ list (Suc n) = (tl list) !!! n
{-# COMPILE AGDA2HS _!!!_ #-}

_range_ : {a : Set} → InfiniteList a → Nat → a
_range_ list Zero = {!   !}
_range_ list (Suc n) = {!   !}