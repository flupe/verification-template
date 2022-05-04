module Data.SimpleList where

data SimpleList a = []
                  | (::) a (SimpleList a)
                      deriving Show

