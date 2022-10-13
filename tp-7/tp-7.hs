

{-
-- Ejercicio 1
heapSort :: Ord a => [a] -> [a] -- O(n)
heapSort xs = ordEnPQ xs (emptyPQ)

ordEnPQ :: Ord a => [a] -> PriorityQueue a -> [a] -- O(n)
ordEnPQ [] pq     = obtenerListaPQ pq 
ordEnPQ (x:xs) pq = ordEnPQ xs (insertPQ x pq) 

obtenerListaPQ :: Ord a => PriorityQueue a -> [a] -- O(n)
obtenerListaPQ pq = if isEmptyPQ pq 
                       then []
                       else (findMinPQ pq) : obtenerListaPQ (deleteMinPQ pq)
-}
-- Ejercicio 2

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

belongsBST :: Ord a => a -> Tree a -> Bool
-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
belongsBST a EmptyT          = False
belongsBST a (NodeT x t1 t2) = a==x || if a<x 
                                          then belongsBST a t1 
                                          else belongsBST a t2

insertBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
insertBST a EmptyT          = NodeT a EmptyT EmptyT
insertBST a (NodeT x t1 t2) = if a==x
                                 then NodeT a t1 t2
                                 else if a<x 
                                         then NodeT x (insertBST a t1) t2
                                         else NodeT x t1 (insertBST a t2)

deleteBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
deleteBST a EmptyT          = EmptyT
deleteBST a (NodeT x t1 t2) = if a==x
                                 then reordenar t1 t2
                                 else if a<x 
                                         then NodeT x (deleteBST a t1) t2 
                                         else NodeT x t1 (deleteBST a t2)

reordenar :: Ord a => Tree a -> Tree a -> Tree a 
reordenar t1 t2 = let (m, t1') = maxBST t1 
                      in NodeT m t1' t2

maxBST :: Ord a => Tree a -> (a, Tree a)
    -- Precond: El Arbol no puede estar vacio
maxBST (NodeT x t1 EmptyT) = (x, t1)
maxBST (NodeT x t1 t2)     = let (m, t2') = maxBST t2 
                                 in (m, NodeT x t1 t2')

splitMinBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMinBST (NodeT x EmptyT t2) = (x, t2)
splitMinBST (NodeT x t1 t2)     = let (m, t1') = splitMinBST t1
                                      in (m, NodeT x t1' t2)

splitMaxBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMaxBST (NodeT x t1 EmptyT) = (x, t1)
splitMaxBST (NodeT x t1 t2)     = let (m, t2') = splitMaxBST t2
                                      in (m, NodeT x t1 t2')

-- esBST :: Tree a -> Bool
-- Propósito: indica si el árbol cumple con los invariantes de BST.
-- Costo: O(N^2)

elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
-- elemento dado.
-- Costo: O(log N)
elMaximoMenorA a EmptyT              = Nothing
elMaximoMenorA a (NodeT x EmptyT t2) = if x<a
                                          then elMaximoMenorA a t2
                                          else Nothing
elMaximoMenorA a (NodeT x t1 EmptyT) = if x<a
                                          then Just x
                                          else elMaximoMenorA a t1
elMaximoMenorA a (NodeT x t1 t2)     = if x<a
                                          then elMaximoMenorA a t2
                                          else elMaximoMenorA a t1

elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
-- elemento dado.
-- Costo: O(log N)
elMinimoMayorA a EmptyT              = Nothing
elMinimoMayorA a (NodeT x EmptyT t2) = if x>a
                                          then Just x
                                          else elMinimoMayorA a t2
elMinimoMayorA a (NodeT x t1 EmptyT) = if x>a
                                          then elMinimoMayorA a t1
                                          else Nothing
elMinimoMayorA a (NodeT x t1 t2)     = if x>a
                                          then elMinimoMayorA a t1
                                          else elMinimoMayorA a t2

balanceado :: Tree a -> Bool
-- Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
-- nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
-- Costo: O(N2)
balanceado 
balanceado 


-- Ejercicio 3
-- Dada la siguiente interfaz y costos para el tipo abstracto Map:
emptyM :: Map k v
-- Costo: O(1).

assocM :: Ord k => k -> v -> Map k v -> Map k v
-- Costo: O(log K).

lookupM :: Ord k => k -> Map k v -> Maybe v
-- Costo: O(log K).

deleteM :: Ord k => k -> Map k v -> Map k v
-- Costo: O(log K).

keys :: Map k v -> [k]
-- Costo: O(K).

-- recalcular el costo de las funciones como usuario de Map de la práctica anterior, siendo K es la
-- cantidad de claves del Map. Justificar las respuestas.

valuesM :: Eq k => Map k v -> [Maybe v] -- O(n)
valuesM m = listaValores (keys m) m  

listaValores :: Eq k => [k] -> Map k v -> [Maybe v] 
listaValores [] m     = []
listaValores (k:ks) m = lookupM k m : listaValores ks m

todasAsociadas :: Eq k => [k] -> Map k v -> Bool -- O(n^2)
todasAsociadas [] m     = True
todasAsociadas (k:ks) m = estaEnElMap k m && todasAsociadas ks m 

estaEnElMap :: Eq k => k -> Map k v -> Bool 
estaEnElMap k m = elem k (keys m)

listToMap :: Eq k => [(k, v)] -> Map k v -- O(n)
-- Propósito: convierte una lista de pares clave valor en un map.
listToMap kvs = agregarTodosAlMap kvs (emptyM)

agregarTodosAlMap :: Eq k => [(k, v)] -> Map k v -> Map k v
agregarTodosAlMap [] m          = m
agregarTodosAlMap ((k,v):kvs) m = agregarTodosAlMap kvs (assocM k v m)

mapToList :: Eq k => Map k v -> [(k,v)] -- O(n)
-- Propósito: convierte un map en una lista de pares clave valor.
mapToList m = asociarTodos (keys m) (valuesM m)

asociarTodos :: Eq k => [k] -> [Maybe v] -> [(k,v)]
asociarTodos [] []         = []
asociarTodos (k:ks) (v:vs) = (k, fromJust v) : asociarTodos ks vs

fromJust :: Maybe a -> a
fromJust (Just a) = a 

agruparEq :: Eq k => [(k, v)] -> Map k [v] -- O(n)
-- Propósito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
-- la misma clave.
agruparEq []          = emptyM
agruparEq ((k,v):kvs) = let x = agruparEq kvs in   
                            case lookupM k x of
                                Nothing -> assocM k [v] x
                                Just vs -> assocM k (v:vs) x

incrementar :: Eq k => [k] -> Map k Int -> Map k Int -- O(n)
-- -- Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
-- -- cada número asociado con dichas claves.
incrementar [] m     = m
incrementar (k:ks) m = case lookupM k (incrementar ks m) of
                            Nothing -> incrementar ks m
                            Just n  -> assocM k (n+1) (incrementar ks m)  

mergeMaps:: Eq k => Map k v -> Map k v -> Map k v -- O(n)
-- Propósito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
-- una clave del primero existe en el segundo, es reemplazada por la del primero.
mergeMaps m1 m2 = agregarTodosAlMap (mapToList m2) m1

indexar :: [a] -> Map Int a -- O(log n)
-- Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
-- su posición en la lista.
indexar []     = emptyM
indexar (x:xs) = assocM ((head (keys (indexar xs)))+1) x (indexar xs)

ocurrencias :: String -> Map Char Int -- O(n)
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.
ocurrencias []     = emptyM
ocurrencias (c:cs) = case lookupM c (ocurrencias cs) of 
                          Nothing -> assocM c 1 (ocurrencias cs)
                          Just n  -> assocM c (n+1) (ocurrencias cs)

-- Ejercicio 4

type SectorId = Int
type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)

