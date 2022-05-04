
{-# OPTIONS --guardedness #-}
module Data.InfiniteList where

record InfiniteList (@0 A : Set) : Set where
    coinductive
    field
        hd : A
        tl : InfiniteList A
{-# COMPILE AGDA2HS InfiniteList deriving Show #-}

open InfiniteList public

headOfInf : {@0 A : Set} → InfiniteList A → A
headOfInf input = hd input
{-# COMPILE AGDA2HS headOfInf #-}