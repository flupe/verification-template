module Data.Delay where

import Data.Nat

data Delay a = now a
             | later (Thunk (Delay a))

traverseOne :: Delay a -> Delay a
traverseOne (now x) = now x
traverseOne (later x) = force x

