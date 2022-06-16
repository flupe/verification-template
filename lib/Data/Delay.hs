module Data.Delay where

import Data.Thunk

import Data.Nat

data Delay a = Now a
             | Later (Thunk (Delay a))

traverseOne :: Delay a -> Delay a
traverseOne (Now x) = Now x
traverseOne (Later x) = force x

