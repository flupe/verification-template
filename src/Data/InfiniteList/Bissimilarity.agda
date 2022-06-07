{-# OPTIONS --guardedness #-}
module Data.InfiniteList.Bissimilarity where

open import Haskell.Prim

open import Data.InfiniteList
open import Data.Nat

-- Helper for bissimilarity checks

record _≈_ {a} (xs : InfiniteList a) (ys : InfiniteList a) : Set where
      coinductive
      field
        hd-≡ : hd xs ≡ hd ys
        tl-≈ : tl xs ≈ tl ys

open _≈_

-- Bissimilairty for simpler functions

drop-head-bissimular-tail-head : ∀ {a} (list : InfiniteList a) → hdInf(dropInf list (Suc Zero)) ≡ hdInf(tlInf list)
drop-head-bissimular-tail-head _ = refl

tail-head-bissimular-index : ∀ {a} (list : InfiniteList a) → hdInf(tlInf (tlInf (tlInf (tlInf list)))) ≡ list !!! Suc (Suc (Suc (Suc Zero)))
tail-head-bissimular-index _ = refl

-- This doesn't work, no clue why.
-- tail-head-bissimular-take-index : ∀ {a} (list : InfiniteList a) → hdInf(tlInf (tlInf (tlInf (tlInf list)))) ≡ (takeInf list (Suc (Suc (Suc (Suc (Suc (Suc Zero))))))) !!! Suc (Suc (Suc (Suc Zero)))
-- tail-head-bissimular-take-index _ = refl
-- Bissimilarity for higher order functions

merge-bissimular-split : ∀ {a} (list : InfiniteList a) → merge (split list) ≈ list
hd-≡ (merge-bissimular-split _) = refl
tl-≈ (merge-bissimular-split list) = merge-bissimular-split (tlInf list)

map-bissimular-hd-function : ∀ {a b} (list : InfiniteList a) (f : (a → b)) → f (hd list) ≡ hd (map list f)
map-bissimular-hd-function _ _ = refl
