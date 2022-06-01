{-# OPTIONS --guardedness #-}
module Data.InfiniteList.Properties where

record _≈_ {a} (xs : InfiniteList a) (ys : InfiniteList a) : Set where
      coinductive
      field
        hd-≡ : hd xs ≡ hd ys
        tl-≈ : tl xs ≈ tl ys

open _≈_

merge-split-id : ∀ {a} (list : InfiniteList a) → merge (split list) ≈ list
hd-≡ (merge-split-id _) = refl
tl-≈ (merge-split-id list) = merge-split-id (tl list)