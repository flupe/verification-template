module Data.Tree where

data Tree a = Leaf
            | Node a (Tree a) (Tree a)
                deriving Show

instance Foldable Tree where
    foldMap f Leaf = mempty
    foldMap f (Node x l r) = foldMap f l <> f x <> foldMap f r

instance Functor Tree where
    fmap f Leaf = Leaf
    fmap f (Node x l r) = Node (f x) (fmap f l) (fmap f r)

instance Traversable Tree where
    traverse f Leaf = pure Leaf
    traverse f (Node x l r)
      = pure Node <*> f x <*> traverse f l <*> traverse f r

size :: Tree a -> Integer
size Leaf = 0
size (Node x l r) = 1 + size l + size r

depth :: Tree a -> Integer
depth Leaf = 0
depth (Node x l r) = 1 + max (depth l) (depth r)

insert :: Ord a => a -> Tree a -> Tree a
insert v Leaf = Node v Leaf Leaf
insert v (Node x l r)
  = case compare v x of
        LT -> Node x (insert v l) r
        EQ -> Node x l r
        GT -> Node x l (insert v r)

fromList :: Ord a => [a] -> Tree a
fromList = foldr insert Leaf

