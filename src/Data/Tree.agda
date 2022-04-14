module Data.Tree where

open import Haskell.Prelude
import Haskell.Prim.Ord as Ord


data Tree (a : Set) : Set where
  Leaf : Tree a
  Node : (x : a) (left right : Tree a) → Tree a
{-# COMPILE AGDA2HS Tree deriving Show #-}


instance
  iFoldable : Foldable Tree
  iFoldable .foldMap f Leaf = mempty
  iFoldable .foldMap f (Node x l r) = foldMap f l <> f x <> foldMap f r
  {-# COMPILE AGDA2HS iFoldable #-}


  iFunctor : Functor Tree
  iFunctor .fmap f Leaf = Leaf
  iFunctor .fmap f (Node x l r) = Node (f x) (fmap f l) (fmap f r)
  {-# COMPILE AGDA2HS iFunctor #-}


  iTraversable : Traversable Tree
  iTraversable .traverse f Leaf = pure Leaf
  iTraversable .traverse f (Node x l r) = ⦇ Node (f x) (traverse f l) (traverse f r) ⦈
  {-# COMPILE AGDA2HS iTraversable #-}


size : Tree a → Integer
size Leaf = 0
size (Node x l r) = 1 + size l + size r
{-# COMPILE AGDA2HS size #-}


depth : Tree a → Integer
depth Leaf = 0
depth (Node x l r) = 1 + max (depth l) (depth r)
{-# COMPILE AGDA2HS depth #-}


insert : ⦃ Ord a ⦄ → a → Tree a → Tree a
insert v Leaf = Node v Leaf Leaf
insert v (Node x l r) =
  case compare v x of λ where
    LT → Node x (insert v l) r
    EQ → Node x l r
    GT → Node x l (insert v r)
{-# COMPILE AGDA2HS insert #-}


fromList : ⦃ Ord a ⦄ → List a → Tree a
fromList = foldr insert  Leaf
{-# COMPILE AGDA2HS fromList #-}
