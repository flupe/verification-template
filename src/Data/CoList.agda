{-# OPTIONS --guardedness #-}
{-# OPTIONS --sized-types #-}
module Data.CoList where

open import Agda.Builtin.Size

open import Haskell.Prim
open import Haskell.Prim.Maybe

open import Data.Thunk
{-# FOREIGN AGDA2HS
import Data.Thunk
#-}
open import Data.Nat
{-# FOREIGN AGDA2HS
import Data.Nat
#-}

data CoList (a : Set) (@0 i : Size) : Set where
  Nil  : CoList a i
  _:::_ : a → Thunk (CoList a) i → CoList a i
{-# COMPILE AGDA2HS CoList #-}

-- Special constructors
-- Compile pragmas are commented out because they are unsupported as of now
repeatCoList : {a : Set} {@0 i : Size} → a → CoList a i
repeatCoList x = x ::: (λ where .force → repeatCoList x)
-- {-# COMPILE AGDA2HS repeatCoList #-}

fibonacciCoList : {@0 i : Size} → Nat → Nat → CoList Nat i
fibonacciCoList n1 n2 = n1 ::: (λ where .force → (n2 ::: λ where .force → (fibonacciCoList n2 (n1 +++ n2))))
-- {-# COMPILE AGDA2HS fibonacciCoList #-}

-- Basic Functions

hdCoList : {a : Set} {@0 i : Size} → CoList a i → Maybe a
hdCoList Nil = Nothing
hdCoList (x ::: xs) = Just x
{-# COMPILE AGDA2HS hdCoList #-}

tlCoList : {a : Set} {@0 i : Size} → CoList a (↑ i) → CoList a i
tlCoList Nil = Nil
tlCoList (x ::: xs) = (xs .force)
{-# COMPILE AGDA2HS tlCoList #-}

_!!!_ : {a : Set} {@0 i : Size} → CoList a ∞ → Nat → Maybe a 
Nil !!! _ = Nothing
(x ::: xs) !!! Zero = Just x
(x ::: xs) !!! Suc n = (xs .force) !!! n
{-# COMPILE AGDA2HS _!!!_ #-}

takeCoList : {a : Set} → Nat → CoList a ∞ → List a
takeCoList _ Nil = []
takeCoList Zero xs = []
takeCoList (Suc n) (x ::: xs) = x ∷ takeCoList n (xs .force)
{-# COMPILE AGDA2HS takeCoList #-}

dropCoList : {a : Set} {@0 i : Size} → Nat → CoList a ∞ → CoList a i
dropCoList _ Nil = Nil
dropCoList Zero xs = xs
dropCoList (Suc n) (x ::: xs) = dropCoList n (xs .force) 
{-# COMPILE AGDA2HS dropCoList #-} 