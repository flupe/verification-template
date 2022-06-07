module Data.Delay where

data Delay a = now a
             | later (Thunk (Delay a))

