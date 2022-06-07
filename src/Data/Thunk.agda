{-# OPTIONS --guardedness #-}
{-# OPTIONS --sized-types #-}
module Data.Thunk where

open import Agda.Builtin.Size

record Thunk (a : @0 Size → Set) (@0 i : Size) : Set where
  coinductive
  field
    force : {@0 j : Size< i} → a j
open Thunk public
{-# COMPILE AGDA2HS Thunk #-}