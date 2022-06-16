{-# OPTIONS --guardedness #-}
{-# OPTIONS --sized-types #-}
module Data.Delay where

open import Agda.Builtin.Size

open import Haskell.Prim

open import Data.Thunk
{-# FOREIGN AGDA2HS 
import Data.Thunk
#-}
open import Data.Nat
{-# FOREIGN AGDA2HS
import Data.Nat
#-}

data Delay (a : Set) (@0 i : Size) : Set where
    Now : a → Delay a i
    Later : Thunk (Delay a) i → Delay a i
{-# COMPILE AGDA2HS Delay #-}

traverseOne : {a : Set} {@0 i : Size} {@0 j : Size< i} → Delay a i → Delay a j
traverseOne (Now x) = Now x
traverseOne (Later x) = force x
{-# COMPILE AGDA2HS traverseOne #-}
