{-# OPTIONS --guardedness #-}
{-# OPTIONS --sized-types #-}
module Data.CoList where

open import Agda.Builtin.Size

open import Haskell.Prim

open import Data.Thunk

data CoList (a : Set) (@0 i : Size) : Set where
  []  : CoList a i
  _∷_ : a → Thunk (CoList a) i → CoList a i
{-# COMPILE AGDA2HS CoList #-}