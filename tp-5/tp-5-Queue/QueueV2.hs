module QueueV2
        (Queue,emptyQ,isEmptyQ,enqueue,firstQ,dequeue)
    where

data Queue a = Q [a] Int
-- INV.REP
--      * El primer elemento que entra en la cola es el primero
--        que sale

--Crea una cola vacía.
emptyQ :: Queue a
emptyQ = Q [] 0 -- O(1)

-- Dada una cola indica si la cola está vacía.
isEmptyQ :: Queue a -> Bool
isEmptyQ (Q xs n) = null xs -- O(1)

-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue :: a -> Queue a -> Queue a
enqueue x (Q ys n) = Q (colocarAlFinal x ys) (n+1) -- O(n)

-- Dada una cola devuelve el primer elemento de la cola.
firstQ :: Queue a -> a
firstQ (Q xs n) = head xs -- O(1)

-- Dada una cola la devuelve sin su primer elemento.
dequeue :: Queue a -> Queue a
dequeue (Q xs n) = Q (tail xs) (n-1) -- O(1)


-- Subtareas
colocarAlFinal :: a -> [a] -> [a]
colocarAlFinal x []     = x:[]
colocarAlFinal x (y:ys) = y : colocarAlFinal x ys

