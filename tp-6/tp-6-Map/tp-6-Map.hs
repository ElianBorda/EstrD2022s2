import MapV2

m = assocM 5 "f"
    $ assocM 4 "c"
    $ assocM 3 "c"
    $ assocM 2 "b"
    $ assocM 1 "a" 
    $ emptyM


-- M [(k,v)]
-- Hay solo una clave unica por valor en el Map
 

valuesM :: Eq k => Map k v -> [Maybe v] -- O(n^2), a cada k en listaDeValores se le aplica lookupM O(n)
valuesM m = listaValores (keys m) m  

listaValores :: Eq k => [k] -> Map k v -> [Maybe v] 
listaValores [] m     = []
listaValores (k:ks) m = lookupM k m : listaValores ks m

todasAsociadas :: Eq k => [k] -> Map k v -> Bool -- O(n^2), a cada k se le aplica estaEnElMap O(n) con k m 
-- Propósito: indica si en el map se encuentran todas las claves dadas.
todasAsociadas [] m     = True
todasAsociadas (k:ks) m = estaEnElMap k m && todasAsociadas ks m 

estaEnElMap :: Eq k => k -> Map k v -> Bool -- O
estaEnElMap k m = elem k (keys m)

listToMap :: Eq k => [(k, v)] -> Map k v
-- Propósito: convierte una lista de pares clave valor en un map.
listToMap kvs = agregarTodosAlMap kvs (emptyM)

agregarTodosAlMap :: Eq k => [(k, v)] -> Map k v -> Map k v
agregarTodosAlMap [] m          = m
agregarTodosAlMap ((k,v):kvs) m = agregarTodosAlMap kvs (assocM k v m)

mapToList :: Eq k => Map k v -> [(k,v)]
-- Propósito: convierte un map en una lista de pares clave valor.
mapToList m = asociarTodos (keys m) (valuesM m)

asociarTodos :: Eq k => [k] -> [Maybe v] -> [(k,v)]
asociarTodos [] []         = []
asociarTodos (k:ks) (v:vs) = (k, fromJust v) : asociarTodos ks vs

fromJust :: Maybe a -> a
fromJust (Just a) = a 


-- agruparEq :: Eq k => [(k, v)] -> Map k [v]
-- Propósito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
-- la misma clave.
-- agruparEq []          = emptyM
-- agruparEq ((k,v):kvs) = assocM k (v:lookupParaLista k kvs) (agruparEq (removeK k kvs))

-- lookupParaLista :: Eq k => k -> [(k,v)] -> [v]
-- lookupParaLista k []            = []
-- lookupParaLista k ((k1,v1):kvs) = if k==k1
--                                      then v1 : lookupParaLista k kvs
--                                      else lookupParaLista k kvs

-- removeK :: Eq k => k -> [(k,v)] -> [(k,v)]
-- removeK k []            = []
-- removeK k ((k1,v1):kvs) = if k==k1
--                              then removeK k kvs
--                              else (k1,v1) : removeK k kvs

agruparEq :: Eq k => [(k, v)] -> Map k [v]
-- Propósito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
-- la misma clave.
agruparEq []          = emptyM
agruparEq ((k,v):kvs) = let x = agruparEq kvs in   
                            case lookupM k x of
                                Nothing -> assocM k [v] x
                                Just vs -> assocM k (v:vs) x

-- incrementar :: Eq k => [k] -> Map k Int -> Map k Int
-- -- Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
-- -- cada número asociado con dichas claves.
-- incrementar [] m     = m
-- incrementar (k:ks) m = incrementar (eliminarDe k ks) (assocM k (apariciones k (k:ks)) m)

-- apariciones :: Eq a => a -> [a] -> Int
-- apariciones _ []       = 0
-- apariciones x (y:ys)   = if x==y 
--                           then 1+(apariciones x ys)
--                           else apariciones x ys

-- eliminarDe :: Eq k => k -> [k] -> [k]
-- eliminarDe k []      = []
-- eliminarDe k (k1:ks) = if k==k1 
--                           then eliminarDe k ks
--                           else k1 : eliminarDe k ks 

incrementar :: Eq k => [k] -> Map k Int -> Map k Int
-- -- Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
-- -- cada número asociado con dichas claves.
incrementar [] m     = m
incrementar (k:ks) m = case lookupM k (incrementar ks m) of
                            Nothing -> incrementar ks m
                            Just n  -> assocM k (n+1) (incrementar ks m)  

mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
-- Propósito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
-- una clave del primero existe en el segundo, es reemplazada por la del primero.
mergeMaps m1 m2 = agregarTodosAlMap (mapToList m2) m1

indexar :: [a] -> Map Int a
-- Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
-- su posición en la lista.
indexar []     = emptyM
indexar (x:xs) = assocM ((head (keys (indexar xs)))+1) x (indexar xs)

ocurrencias :: String -> Map Char Int
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.
ocurrencias []     = emptyM
ocurrencias (c:cs) = case lookupM c (ocurrencias cs) of 
                          Nothing -> assocM c 1 (ocurrencias cs)
                          Just n  -> assocM c (n+1) (ocurrencias cs)