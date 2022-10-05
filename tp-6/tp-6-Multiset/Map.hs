module Map
        (Map,emptyM,assocM,lookupM,deleteM,keys)
    where
        
data Map k v = M [(k, v)]

-- INV.REP: para (M [(k, v)])
--     k es unico en el map

emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M [] -- O(1)

assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v (M kvs) = M (agregarSiNoExiste k v kvs) -- O(n)

lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM k (M kvs) = valorSiEsta k kvs -- O(n)

deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
deleteM k (M kvs) = M (borrar k kvs) -- O(n)

keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map
keys (M kvs) = listKeys kvs -- O(n)

agregarSiNoExiste :: Eq k => k -> v -> [(k,v)] -> [(k,v)]
agregarSiNoExiste k v []            = [(k,v)]
agregarSiNoExiste k v ((k1,v1):kvs) = if k==k1 
                                         then (k1,v1) : kvs
                                         else (k1,v1) : agregarSiNoExiste k v kvs 

valorSiEsta :: Eq k => k -> [(k,v)] -> Maybe v
valorSiEsta k []            = Nothing
valorSiEsta k ((k1,v1):kvs) = if k==k1 
                              then Just v1
                              else valorSiEsta k kvs

borrar :: Eq k => k -> [(k,v)] -> [(k,v)]
borrar k []            = []
borrar k ((k1,v1):kvs) = if k==k1 
                            then kvs
                            else (k1,v1) : borrar k kvs 

listKeys :: [(k,v)] -> [k]
listKeys []          = []
listKeys ((k,v):kvs) = k : listKeys kvs