import QueueV2

queue1 = enqueue 4 (enqueue 3 (enqueue 2 (enqueue 1 (emptyQ))))

-- Cuenta la cantidad de elementos de la cola.
lengthQ :: Queue a -> Int
lengthQ (Q xs n) = n

-- Dada una cola devuelve la lista con los mismos elementos,
-- donde el orden de la lista es el de la cola.
-- Nota: chequear que los elementos queden en el orden correcto.
queueToList :: Queue a -> [a]
queueToList (Q xs n) = xs

-- Inserta todos los elementos de la segunda cola en la primera.
-- unionQ :: Queue a -> Queue a -> Queue a

