

{-
-- Ejercicio 1
heapSort :: Ord a => [a] -> [a] -- O(n)
heapSort xs = ordEnPQ xs (emptyPQ)

ordEnPQ :: Ord a => [a] -> PriorityQueue a -> [a] -- O(n)
ordEnPQ [] pq     = obtenerListaPQ pq 
ordEnPQ (x:xs) pq = ordEnPQ xs (insertPQ x pq) 

obtenerListaPQ :: Ord a => PriorityQueue a -> [a] -- O(n)
obtenerListaPQ pq = if isEmptyPQ pq 
                       then []
                       else (findMinPQ pq) : obtenerListaPQ (deleteMinPQ pq)
-}
-- Ejercicio 2

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

belongsBST :: Ord a => a -> Tree a -> Bool
-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
belongsBST a EmptyT          = False
belongsBST a (NodeT x t1 t2) = a==x || if a<x 
                                          then belongsBST a t1 
                                          else belongsBST a t2

insertBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
insertBST a EmptyT          = NodeT a EmptyT EmptyT
insertBST a (NodeT x t1 t2) = if a==x
                                 then NodeT a t1 t2
                                 else if a<x 
                                         then NodeT x (insertBST a t1) t2
                                         else NodeT x t1 (insertBST a t2)

deleteBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
deleteBST a EmptyT          = EmptyT
deleteBST a (NodeT x t1 t2) = if a==x
                                 then reordenar t1 t2
                                 else if a<x 
                                         then NodeT x (deleteBST a t1) t2 
                                         else NodeT x t1 (deleteBST a t2)

reordenar :: Ord a => Tree a -> Tree a -> Tree a 
reordenar t1 t2 = let (m, t1') = maxBST t1 
                      in NodeT m t1' t2

maxBST :: Ord a => Tree a -> (a, Tree a)
    -- Precond: El Arbol no puede estar vacio
maxBST (NodeT x t1 EmptyT) = (x, t1)
maxBST (NodeT x t1 t2)     = let (m, t2') = maxBST t2 
                                 in (m, NodeT x t1 t2')

splitMinBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMinBST (NodeT x EmptyT t2) = (x, t2)
splitMinBST (NodeT x t1 t2)     = let (m, t1') = splitMinBST t1
                                      in (m, NodeT x t1' t2)

splitMaxBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMaxBST (NodeT x t1 EmptyT) = (x, t1)
splitMaxBST (NodeT x t1 t2)     = let (m, t2') = splitMaxBST t2
                                      in (m, NodeT x t1 t2')

esBST :: Tree a -> Bool
-- Propósito: indica si el árbol cumple con los invariantes de BST.
-- Costo: O(N^2)

elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
-- elemento dado.
-- Costo: O(log N)
elMaximoMenorA
elMaximoMenorA


