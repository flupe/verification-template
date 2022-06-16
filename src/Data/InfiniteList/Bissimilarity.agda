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

drop-head-bissimular-tail-head : ∀ {a} (list : InfiniteList a) → hdInf(dropInf (Suc Zero) list) ≡ hdInf(tlInf list)
drop-head-bissimular-tail-head _ = refl

tail-head-bissimular-index : ∀ {a} (list : InfiniteList a) → hdInf(tlInf (tlInf (tlInf (tlInf list)))) ≡ list !!! Suc (Suc (Suc (Suc Zero)))
tail-head-bissimular-index _ = refl

merge-bissimular-split : ∀ {a} (list : InfiniteList a) → mergeInf (splitInf list) ≈ list
hd-≡ (merge-bissimular-split _) = refl
tl-≈ (merge-bissimular-split list) = merge-bissimular-split (tlInf list)

map-bissimular-hd-function : ∀ {a b} (list : InfiniteList a) (f : (a → b)) → f (hd list) ≡ hd (mapInf list f)
map-bissimular-hd-function _ _ = refl
