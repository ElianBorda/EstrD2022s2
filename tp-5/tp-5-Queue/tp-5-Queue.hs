import QueueV2

queue1 = enqueue 4 (enqueue 3 (enqueue 2 (enqueue 1 (emptyQ))))

-- Cuenta la cantidad de elementos de la cola.
lengthQ :: Queue a -> Int
lengthQ q = if isEmptyQ q 
                then 0
                else 1 + lengthQ (dequeue q) -- O(n)

 
-- Dada una cola devuelve la lista con los mismos elementos,
-- donde el orden de la lista es el de la cola.
-- Nota: chequear que los elementos queden en el orden correcto.
queueToList :: Queue a -> [a]
queueToList q = if isEmptyQ q
                    then []
                    else firstQ q : queueToList (dequeue q) -- O(n)

-- Inserta todos los elementos de la segunda cola en la primera.
unionQ :: Queue a -> Queue a -> Queue a
unionQ q1 q2 = if isEmptyQ q2
                    then q1
                    else unionQ (enqueue (firstQ q2) q1) (dequeue q2) -- O(n^2)

