module Data.Thunk where

data Thunk a = Thunk{force :: a}

