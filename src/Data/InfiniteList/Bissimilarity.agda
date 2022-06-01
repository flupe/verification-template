{-# OPTIONS --guardedness #-}
module Data.InfiniteList.Bissimilarity where

open import Haskell.Prim

open import Data.InfiniteList
open import Data.Nat

record _≈_ {a} (xs : InfiniteList a) (ys : InfiniteList a) : Set where
      coinductive
      field
        hd-≡ : hd xs ≡ hd ys
        tl-≈ : tl xs ≈ tl ys

open _≈_

merge-bissimular-split : ∀ {a} (list : InfiniteList a) → merge (split list) ≈ list
hd-≡ (merge-bissimular-split _) = refl
tl-≈ (merge-bissimular-split list) = merge-bissimular-split (tlInf list)

drop-head-bissimular-tail-head : ∀ {a} (list : InfiniteList a) → hdInf(dropInf list (Suc Zero)) ≈ hdInf(tlInf list)
hd-≡ (drop-head-bissimular-tail-head _) = refl
tl-≈ (drop-head-bissimular-tail-head list) = drop-head-bissimular-tail-head (tlInf list)

