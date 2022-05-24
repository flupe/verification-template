{-# OPTIONS --guardedness #-}
module Data.InfiniteList where

open import Haskell.Prim

open import Data.Nat
{-# FOREIGN AGDA2HS
import Data.Nat
#-}

record InfiniteList (a : Set) : Set where
    coinductive
    field
        hd : a
        tl : InfiniteList a
{-# COMPILE AGDA2HS InfiniteList #-}

open InfiniteList public

-- Special co-pattern constructors

infNatList : Nat → InfiniteList Nat
hd (infNatList n) = n 
tl (infNatList n) = (infNatList (Suc n)) 
{-# COMPILE AGDA2HS infNatList #-}

repeatInf : {a : Set} (x : a) → InfiniteList a
hd (repeatInf x) = x
tl (repeatInf x) = repeatInf x
{-# COMPILE AGDA2HS repeatInf #-}

fibonacci : Nat → Nat → InfiniteList Nat
hd (fibonacci n1 n2) = n1
tl (fibonacci n1 n2) = (fibonacci (n2) (n1 +++ n2))
{-# COMPILE AGDA2HS fibonacci #-}

-- Basic functions

hdInf  : {a : Set} → InfiniteList a → a
hdInf list = hd list
{-# COMPILE AGDA2HS hdInf #-} 

tlInf : {a : Set} → InfiniteList a → InfiniteList a
tlInf list = tl list
{-# COMPILE AGDA2HS tlInf #-}

_!!!_ : {a : Set} → InfiniteList a → Nat → a
list !!! Zero = hdInf list
list !!! Suc n = (tlInf list) !!! n 
{-# COMPILE AGDA2HS _!!!_ #-}

takeInf : {a : Set} -> InfiniteList a → Nat → List a
takeInf list Zero = []
takeInf list (Suc n) = (hdInf list) ∷ (takeInf (tlInf list) n)
{-# COMPILE AGDA2HS takeInf #-}

dropInf : {a : Set} → InfiniteList a → Nat → InfiniteList a
dropInf list Zero = list
dropInf list (Suc n) = dropInf (tlInf list) n
{-# COMPILE AGDA2HS dropInf #-}

-- Higher order functions
-- _map_ : {a : Set} → (a → a) → InfiniteList a → InfiniteList a
-- list map f = {!   !}

-- To implement: Bind, Map, Filter
-- Implement a prime infinite, or fibonacci infinite
-- Try other high order functions on lists