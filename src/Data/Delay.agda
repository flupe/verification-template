{-# OPTIONS --guardedness #-}
{-# OPTIONS --sized-types #-}
module Data.Delay where

open import Agda.Builtin.Size

open import Haskell.Prim
open import Data.Thunk

open import Data.Nat
{-# FOREIGN AGDA2HS
import Data.Nat
#-}

data Delay (a : Set) (@0 i : Size) : Set where
    now : a → Delay a i
    later : Thunk (Delay a) i → Delay a i
{-# COMPILE AGDA2HS Delay #-}

traverseOne : {a : Set} {@0 i : Size} {@0 j : Size< i} → Delay a i → Delay a j
traverseOne (now x) = now x
traverseOne (later x) = force x
{-# COMPILE AGDA2HS traverseOne #-}

-- traverse : {a : Set} {@0 i : Size} {@0 j : Size< i} → Delay a i → Nat → Delay a j
-- traverse x Zero = x
-- traverse x (Suc n) = traverse (traverseOne x) n