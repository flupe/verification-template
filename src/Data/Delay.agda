{-# OPTIONS --guardedness #-}
{-# OPTIONS --sized-types #-}
module Data.Delay where

open import Agda.Builtin.Size

open import Haskell.Prim


mutual
    data Delay (i : Size) (a : Set) : Set where
        now : a → Delay i a 
        later : ∞Delay i a → Delay i a
    {-# COMPILE AGDA2HS Delay #-}

    record ∞Delay (i : Size) (a : Set) : Set where
        coinductive
        field
            force : {j : Size< i} → Delay j a
    {-# COMPILE AGDA2HS ∞Delay #-}