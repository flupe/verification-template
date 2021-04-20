module Project where

open import Haskell.Prim.Num
open import Agda.Builtin.Nat hiding (_+_)
open import Agda.Builtin.Equality

-- You can specify which defintions are compiled to Haskell
-- with a COMPILE AGDA2HS directive

data List (a : Set) : Set where
  Nil  : List a
  Cons : a → List a → List a
{-# COMPILE AGDA2HS List deriving (Show, Eq) #-}

-- ^ Here we specify which Haskell instances should be derived

length' : ∀ {a} → List a → Nat
length' Nil = 0
length' (Cons x xs) = 1 + length' xs
{-# COMPILE AGDA2HS length' #-}

concat' : ∀ {a} → List a → List a → List a
concat' Nil ys = ys
concat' (Cons x xs) ys = Cons x (concat' xs ys)
{-# COMPILE AGDA2HS concat' #-}


-- See how properties we want to prove are NOT exported to Haskell

concat-length' : ∀ {a} (xs ys : List a)
              → length' (concat' xs ys) ≡ length' xs + length' ys 
concat-length' Nil ys = refl
concat-length' (Cons x xs) ys rewrite concat-length' xs ys = refl
