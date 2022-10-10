-- Ejercicio 1

-- Indicar el costo de heapsort :: Ord a => [a] -> [a] (de la práctica anterior) suponiendo que
-- el usuario utiliza una priority queue con costos logarítmicos de inserción y borrado (o sea, usa una
-- Heap como tipo de representación).


heapSort :: Ord a => [a] -> [a] -- O(n)
heapSort xs = ordEnPQ xs (emptyPQ)

ordEnPQ :: Ord a => [a] -> PriorityQueue a -> [a] -- O(n)
ordEnPQ [] pq     = obtenerListaPQ pq 
ordEnPQ (x:xs) pq = ordEnPQ xs (insertPQ x pq) 

obtenerListaPQ :: Ord a => PriorityQueue a -> [a] -- O(n)
obtenerListaPQ pq = if isEmptyPQ pq 
                       then []
                       else (findMinPQ pq) : obtenerListaPQ (deleteMinPQ pq)    


-- Ejercicio 2

-- Implementar las siguientes funciones suponiendo que reciben un árbol binario que cumple los
-- invariantes de BST y sin elementos repetidos (despreocuparse por el hecho de que el árbol puede
-- desbalancearse al insertar o borrar elementos). En todos los costos, N es la cantidad de elementos
-- del árbol. Justificar por qué la implementación satisface los costos dados.

belongsBST :: Ord a => a -> Tree a -> Bool
-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
belongsBST a EmptyT          = False
belongsBST a (NodeT x t1 t2) = a==x || if a<x 
                                          then belongsBST a t1
                                          else belongsBST a t2

-- La implementacion recorre un camino del arbol si no se cumple que
-- a == x

insertBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
insertBST a EmptyT
insertBST a (NodeT x t1 t2) = if a==x 
                                 then NodeT a t1 t2 
                                 else if a<x 
                                         then NodeT x (insertBST a t1) t2
                                         else NodeT x t1 (insertBST a t2)

-- La implementacion recorre un camino del arbol si no se cumple
-- que a == x

deleteBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
deleteBST a EmptyT          = EmptyT  
deleteBST a (NodeT x t1 t2) = if a==x 
                                 then rearmarBST t1 t2
                                 else if a<x
                                      then NodeT x (deleteBST a t1) t2
                                      else NodeT x t1 (deleteBST a t2)                                      

rearmarBST :: Ord a => Tree a -> Tree a -> Tree a
rearmarBST t1 t2 = let (m, t1') = splitMaxBST t1   
                       in NodeT m t1' t2

splitMinBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- Costo: O(log N)  
splitMinBST EmptyT          = 
splitMinBST (NodeT x t1 t2) = let (m, t1') = splitMinBST t1
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
{-
INV.REP de BST: * Los elementos estan ordenados
-}
esBST EmptyT          = True
esBST (NodeT x t1 t2) = (todosMenoresQue x t1) && (todosMayoresQue x t2) && (esBST t1 && esBST t2)

todosMenoresQue :: Ord a => a -> Tree a -> Bool
todosMenoresQue a EmptyT          = True
todosMenoresQue a (NodeT x t1 t2) = x < a && todosMenoresQue a t1 && todosMenoresQue a t2

todosMayoresQue :: Ord a => a -> Tree a -> Bool
todosMayoresQue a EmptyT          = True
todosMayoresQue a (NodeT x t1 t2) = x > a && todosMayoresQue a t1 && todosMayoresQue a t2


elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
-- elemento dado.
-- Costo: O(log N)  
elMaximoMenorA a EmptyT              =
elMaximoMenorA a (NodeT x t1 EmptyT) = if a>x 
                                          then Just a 
                                          else elMaximoMenorA a t1
            
elMaximoMenorA a (NodeT x t1 t2)     = if a>x 
                                      then elMaximoMenorA a t2
                                      else elMaximoMenorA a t1

elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
-- elemento dado.
-- Costo: O(log N)

balanceado :: Tree a -> Bool
-- Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
-- nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
-- Costo: O(N^2)
