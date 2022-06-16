{-# OPTIONS --guardedness #-}
module Data.InfiniteList where

open import Haskell.Prim
open import Haskell.Prim.Tuple

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
-- Copatterns compile pragmas are commented out because they are unsupported

infNatList : Nat → InfiniteList Nat
hd (infNatList n) = n 
tl (infNatList n) = (infNatList (Suc n)) 
-- {-# COMPILE AGDA2HS infNatList #-}

repeatInf : {a : Set} (x : a) → InfiniteList a
hd (repeatInf x) = x
tl (repeatInf x) = repeatInf x
-- {-# COMPILE AGDA2HS repeatInf #-}

fibonacci : Nat → Nat → InfiniteList Nat
hd (fibonacci n1 n2) = n1
tl (fibonacci n1 n2) = (fibonacci (n2) (n1 +++ n2))
-- {-# COMPILE AGDA2HS fibonacci #-}

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

takeInf : {a : Set} → Nat → InfiniteList a → List a
takeInf Zero list = []
takeInf (Suc n) list = (hdInf list) ∷ (takeInf n (tlInf list))
{-# COMPILE AGDA2HS takeInf #-}

dropInf : {a : Set} → Nat → InfiniteList a → InfiniteList a
dropInf Zero list = list
dropInf (Suc n) list = dropInf n (tlInf list)
{-# COMPILE AGDA2HS dropInf #-}

-- Higher order functions
-- Copatterns compile pragmas are commented out because they are unsupported

evenInf : {a : Set} → InfiniteList a → InfiniteList a
hd (evenInf xs) = hd xs
tl (evenInf xs) = evenInf (tl (tl xs)) 
-- {-# COMPILE AGDA2HS evenInf #-}

oddInf : {a : Set} → InfiniteList a → InfiniteList a 
oddInf xs = evenInf (tl xs)
-- {-# COMPILE AGDA2HS oddInf #-}

splitInf : {a : Set} → InfiniteList a → InfiniteList a × InfiniteList a
splitInf xs = (evenInf xs , oddInf xs)
-- {-# COMPILE AGDA2HS splitInf #-}

mergeInf : {a : Set} → InfiniteList a × InfiniteList a → InfiniteList a
hd (mergeInf (xs , ys)) = hd xs
tl (mergeInf (xs , ys)) = mergeInf (ys , tl xs) 
-- {-# COMPILE AGDA2HS mergeInf #-}

mapInf : {a b : Set} → InfiniteList a → (a → b) → InfiniteList b
hd (mapInf list f) = f (hd list)
tl (mapInf list f) = mapInf list f
-- {-# COMPILE AGDA2HS mapInf #-}