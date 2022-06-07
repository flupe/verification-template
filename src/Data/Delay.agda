{-# OPTIONS --guardedness #-}
{-# OPTIONS --sized-types #-}
module Data.Delay where

open import Agda.Builtin.Size

open import Haskell.Prim
open import Data.Thunk

data Delay (a : Set) (@0 i : Size) : Set where
    now : a → Delay a i
    later : Thunk (Delay a) i → Delay a i
{-# COMPILE AGDA2HS Delay #-}