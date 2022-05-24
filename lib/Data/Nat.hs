module Data.Nat where

data Nat = Zero
         | Suc Nat

(+++) :: Nat -> Nat -> Nat
Zero +++ Zero = Zero
Zero +++ Suc b = Suc b
Suc a +++ Zero = Suc a
Suc a +++ Suc b = a +++ Suc (Suc b)

