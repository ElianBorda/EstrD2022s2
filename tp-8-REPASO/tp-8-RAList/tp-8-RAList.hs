
data RAList a = MkR Int (Map Int a) (Heap a)
{-
    INV.REP: 
        * La cantidad de elementos en (Map Int a) es igual
          a la cantidad de elementos en (Heap a).
        * Int es el siguiente del indice mas grande en (Map Int a).
        * Int no puede ser negativo. 
        * Int concuerda con la cantidad de elementos en RAList a
        * El utimo elemento agregado es n  
-}

-- (a)
emptyRAL :: RAList a
-- Propósito: devuelve una lista vacía.
-- Eficiencia: O(1).
emptyRAL = MkR 0 emptyM emptyH

isEmptyRAL :: RAList a -> Bool
-- Propósito: indica si la lista está vacía.
-- Eficiencia: O(1).
isEmptyRAL (MkR n mp hp) = n==0


lengthRAL :: RAList a -> Int
-- Propósito: devuelve la cantidad de elementos.
-- Eficiencia: O(1).
lengthRAL (MkR n mp hp) = n

get :: Int -> RAList a -> a
-- Propósito: devuelve el elemento en el índice dado.
-- Precondición: el índice debe existir.
-- Eficiencia: O(log N).
get m (MkR n mp hp) = case lookupM mp m of
                           Just v -> v

minRAL :: Ord a => RAList a -> a
-- Propósito: devuelve el mínimo elemento de la lista.
-- Precondición: la lista no está vacía.
-- Eficiencia: O(1).
minRAL (MkR n mp hp) = findMin hp

add :: Ord a => a -> RAList a -> RAList a
-- Propósito: agrega un elemento al final de la lista.
-- Eficiencia: O(log N).
add a (MkR n mp hp) = MkR (n+1) (assocM n a mp) (insertH a hp)

elems :: Ord a => RAList a -> [a]
-- Propósito: transforma una RAList en una lista, respetando el orden de los elementos.
-- Eficiencia: O(N log N).
elems (MkR n mp hp) = transformList n mp 

transformList :: Ord a => Int -> Map Int a -> [a] -- O(N log N)
transformList 0 mp = []
transformList n mp = lookupM mp (n-1) : transformList (n-1) mp
 

remove :: Ord a => RAList a -> RAList a
-- Propósito: elimina el último elemento de la lista.
-- Precondición: la lista no está vacía.
-- Eficiencia: O(N log N).
remove (MkR n mp hp) = let (mp', hp') = deleteLastElem (n-1) mp (emptyH)
                           in MkR (n-1) mp' hp'

deleteLastElem :: Ord a => Int -> Map Int a -> Heap a -> (Map Int a, Heap a) 
deleteLastElem 0 mp hp = (deleteM 0 mp, hp)
deleteLastElem n mp hp = case lookupM mp n of 
                              Just v -> deleteLastElem (n-1) mp (insert v hp)

set :: Ord a => Int -> a -> RAList a -> RAList a
-- Propósito: reemplaza el elemento en la posición dada.
-- Precondición: el índice debe existir.
-- Eficiencia: O(N log N).
set m a (MkR n mp hp) = set' m a (n-1) (MkR n mp hp) 

set' :: Ord a => Int -> a -> Int -> RAList a -> RAList a -- O(N log N)
set' m a 0 (MkR n mp hp) =if 0==m
                              then MkR n (assocM 0 a mp) (insertH a hp)
                              else MkR n mp (insertH (fromJust (lookupM mp 0)) hp)
set' m a k (MkR n mp hp) = if k==m 
                              then set' m a (k-1) (MkR n (assocM m a mp) (insertH a hp))
                              else set' m a (k-1) (MkR n mp (insertH (fromJust (lookupM mp k)) hp))

addAt :: Ord a => Int -> a -> RAList a -> RAList a
-- Propósito: agrega un elemento en la posición dada.
-- Precondición: el índice debe estar entre 0 y la longitud de la lista.
-- Observación: cada elemento en una posición posterior a la dada pasa a estar en su posición siguiente.
-- Eficiencia: O(N log N).
-- Sugerencia: definir una subtarea que corra los elementos del Map en una posición a partir de una posición dada. Pasar
-- también como argumento la máxima posición posible.