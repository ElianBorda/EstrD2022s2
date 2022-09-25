module QueueV1
        (Queue,emptyQ,isEmptyQ,enqueue,firstQ,dequeue)
    where

data Queue a = Q [a]

--Crea una cola vacía.
emptyQ :: Queue a
emptyQ = Q []

-- Dada una cola indica si la cola está vacía.
isEmptyQ :: Queue a -> Bool
isEmptyQ (Q xs) = null xs

-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue :: a -> Queue a -> Queue a
enqueue x (Q ys) = Q (x:xs)

-- Dada una cola devuelve el primer elemento de la cola.
firstQ :: Queue a -> a

-- Dada una cola la devuelve sin su primer elemento.
dequeue :: Queue a -> Queue a
