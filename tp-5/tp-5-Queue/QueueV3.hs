module QueueV3
        (Queue,emptyQ,isEmptyQ,enqueue,firstQ,dequeue)
    where

data Queue a = Q [a] [a]
-- INV.REP
--      * El primer elemento que entra en la cola es el primero
--        que sale
--      * Si fs es vacia entonces bs es vacia

--Crea una cola vacía.
emptyQ :: Queue a
emptyQ = Q [] []  -- O(1)

-- Dada una cola indica si la cola está vacía.
isEmptyQ :: Queue a -> Bool
isEmptyQ (Q xs fs) = null fs -- O(1)

-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue :: a -> Queue a -> Queue a
enqueue x (Q ys fs) = if null fs 
                        then Q ys (colocarAlFinal x fs)  -- O(n)
                        else Q (colocarAlFinal x ys) fs
                        
-- Dada una cola devuelve el primer elemento de la cola.
firstQ :: Queue a -> a
firstQ (Q xs fs) = if null fs 
                      then error "No hay elementos" -- O(1)
                      else if null xs 
                               then head fs
                               else head xs 

-- Dada una cola la devuelve sin su primer elemento.
dequeue :: Queue a -> Queue a
dequeue (Q xs fs) = if null fs 
                        then error "No hay elementos"
                        else if null xs
                             then Q xs (tail fs)
                             else Q (tail xs) fs -- O(1)


-- Subtareas
colocarAlFinal :: a -> [a] -> [a]
colocarAlFinal x []     = x:[]
colocarAlFinal x (y:ys) = y : colocarAlFinal x ys

