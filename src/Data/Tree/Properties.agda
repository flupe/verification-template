module Data.Tree.Properties where

open import Data.Tree
open import Haskell.Prelude


_≤_ : ⦃ Ord a ⦄ → a → a → Set
x ≤ y = IsTrue (x <= y)

_≤_≤_ : ⦃ Ord a ⦄ → a → Tree a → a → Set
l ≤ Leaf         ≤ u = l ≤ u
l ≤ Node x tˡ tʳ ≤ u = (l ≤ tˡ ≤ x) × (x ≤ tʳ ≤ u)


Ordered : ⦃ _ : Ord a ⦄ → Ordering → (x y : a) → Set
Ordered GT x y = (y ≤ x)
Ordered EQ x y = IsTrue (x == y)
Ordered LT x y = (x ≤ y)


-- A good Ord instance should have a compare function consistant with <= and ==
record GoodOrd (a : Set) ⦃ _ : Ord a ⦄ : Set where
  field goodCompare : (x y : a) → Ordered (compare x y) x y
open GoodOrd ⦃...⦄


instance
  iNatGoodOrd : GoodOrd Nat
  iNatGoodOrd .goodCompare zero zero = IsTrue.itsTrue
  iNatGoodOrd .goodCompare zero (suc _) = IsTrue.itsTrue
  iNatGoodOrd .goodCompare (suc _) zero = IsTrue.itsTrue
  iNatGoodOrd .goodCompare (suc x) (suc y) = sucOrd (goodCompare x y)
    where
      sucOrd : ∀ {o x y} → Ordered o x y → Ordered o (suc x) (suc y)
      sucOrd {o = LT} = id
      sucOrd {o = EQ} = id
      sucOrd {o = GT} = id


insert-correct : ⦃ _ : Ord a ⦄ ⦃ _ : GoodOrd a ⦄ {l x u : a} {t : Tree a}
  → l ≤ t ≤ u
  → l ≤ x
  → x ≤ u
  → l ≤ insert x t ≤ u
insert-correct {x = x} {t = Leaf        } l≤t≤u l≤x x≤u = l≤x ∷ x≤u ∷ []
insert-correct {x = x} {t = Node v tˡ tʳ} (l≤tˡ≤v ∷ v≤tʳ≤u ∷ []) l≤x x≤u
  with compare x v | goodCompare x v
... | LT | x≤v = insert-correct l≤tˡ≤v l≤x x≤v ∷ v≤tʳ≤u ∷ []
... | EQ | x≡v = l≤tˡ≤v ∷ v≤tʳ≤u ∷ []
... | GT | v≤x = l≤tˡ≤v ∷ (insert-correct v≤tʳ≤u v≤x x≤u) ∷ []
