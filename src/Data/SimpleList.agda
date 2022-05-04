module Data.SimpleList where

infixr 40 _::_
data SimpleList (a : Set) : Set where
    [] : SimpleList a
    _::_ : a -> SimpleList a -> SimpleList a
{-# COMPILE AGDA2HS SimpleList deriving Show #-}