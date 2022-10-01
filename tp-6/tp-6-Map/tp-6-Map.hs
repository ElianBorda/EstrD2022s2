import MapV1

m = assocM 5 "f"
    $ assocM 4 "c"
    $ assocM 3 "c"
    $ assocM 2 "b"
    $ assocM 1 "a" 
    $ emptyM


-- M [(k,v)]
-- Hay solo una clave unica por valor en el Map
 

valuesM :: Eq k => Map k v -> [Maybe v]
-- Propósito: obtiene los valores asociados a cada clave del map.
valuesM m = listaValores (keys m) m  

listaValores :: Eq k => [k] -> Map k v -> [Maybe v]
listaValores [] m     = []
listaValores (k:ks) m = lookupM k m : listaValores ks m

todasAsociadas :: Eq k => [k] -> Map k v -> Bool
-- Propósito: indica si en el map se encuentran todas las claves dadas.
todasAsociadas [] m     = True
todasAsociadas (k:ks) m = estaEnElMap k m && todasAsociadas ks m 

estaEnElMap :: Eq k => k -> Map k v -> Bool
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


agruparEq :: Eq k => [(k, v)] -> Map k [v]
agruparEq []          = emptyM
agruparEq ((k,v):kvs) = assocM k (v:lookupParaLista k kvs) (agruparEq (removeK k kvs))

lookupParaLista :: Eq k => k -> [(k,v)] -> [v]
lookupParaLista k []            = []
lookupParaLista k ((k1,v1):kvs) = if k==k1
                                     then v1 : lookupParaLista k kvs
                                     else lookupParaLista k kvs

removeK :: Eq k => k -> [(k,v)] -> [(k,v)]
removeK k []            = []
removeK k ((k1,v1):kvs) = if k==k1
                             then removeK k kvs
                             else (k1,v1) : removeK k kvs

