module PriorityQueueV1
        (PriorityQueue, emptyPQ,isEmptyPQ,insertPQ,findMinPQ,deleteMinPQ)
    where

data PriorityQueue a = PQ [a]   

emptyPQ :: PriorityQueue a
-- Propósito: devuelve una priority queue vacía.
emptyPQ = PQ [] -- O(1)

isEmptyPQ :: PriorityQueue a -> Bool
-- Propósito: indica si la priority queue está vacía.
isEmptyPQ (PQ xs) = null xs -- O(1)

insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a
-- Propósito: inserta un elemento en la priority queue.
insertPQ x (PQ ys) = PQ (agregarPQ x ys) -- O(n)

findMinPQ :: Ord a => PriorityQueue a -> a
-- Propósito: devuelve el elemento más prioriotario (el mínimo) de la priority queue.
-- Precondición: parcial en caso de priority queue vacía.
findMinPQ (PQ xs) = head xs -- O(1)

deleteMinPQ :: Ord a => PriorityQueue a -> PriorityQueue a
-- Propósito: devuelve una priority queue sin el elemento más prioritario (el mínimo).
-- Precondición: parcial en caso de priority queue vacía.
deleteMinPQ (PQ xs) = PQ (tail xs) -- O(1)

agregarPQ :: Ord a => a -> [a] -> [a]
agregarPQ x []     = [x]
agregarPQ x (y:ys) = if x<y 
                        then x : y : ys
                        else y : agregarPQ x ys

