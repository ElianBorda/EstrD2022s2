import PriorityQueueV1

pru = ([9,8,7,2,3,4,5,6,1,0])

heapSort :: Ord a => [a] -> [a]
heapSort xs = ordEnPQ xs (emptyPQ)

ordEnPQ :: Ord a => [a] -> PriorityQueue a -> [a]
ordEnPQ [] pq     = obtenerListaPQ pq 
ordEnPQ (x:xs) pq = ordEnPQ xs (insertPQ x pq) -- O(n^2)

obtenerListaPQ :: Ord a => PriorityQueue a -> [a]
obtenerListaPQ pq = if isEmptyPQ pq 
                       then []
                       else (findMinPQ pq) : obtenerListaPQ (deleteMinPQ pq)