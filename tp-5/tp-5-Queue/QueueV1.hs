module QueueV1
        (Queue,emptyQ,isEmptyQ,enqueue,firstQ,dequeue)
    where

data Queue a = Q [a] Int

--Crea una cola vacía.
emptyQ :: Queue a
emptyQ = Q [] 0 -- O(1)

-- Dada una cola indica si la cola está vacía.
isEmptyQ :: Queue a -> Bool
isEmptyQ (Q xs n) = null xs -- O(1)

-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue :: a -> Queue a -> Queue a
enqueue x (Q ys n) = Q (x:ys) (n+1) -- O(1)

-- Dada una cola devuelve el primer elemento de la cola.
firstQ :: Queue a -> a
firstQ (Q xs n) = primeroDeLista xs -- O(n)

-- Dada una cola la devuelve sin su primer elemento.
dequeue :: Queue a -> Queue a
dequeue (Q xs n) = Q (colaDeLista xs) (n-1) -- O(n)


-- Subtareas

primeroDeLista :: [a] -> a
primeroDeLista (x:[]) = x
primeroDeLista (x:xs) = primeroDeLista xs 

colaDeLista :: [a] -> [a]
colaDeLista (x:[]) = []
colaDeLista (x:xs) = x : colaDeLista xs  

