module MapV2
        (Map,emptyM,assocM,lookupM,deleteM,keys)
    where



data Map k v = M [k] [v] 

-- INV.REP: para M [k] [v]
--     [v] tiene la misma longitud que [k]

emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M [] [] -- O(1)

assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v (M ks vs) = M (noKeyAssocSi k ks) (noValueAssocSi (noKeyAssocSi k ks) v vs) -- O(1)

lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM k (M ks vs) = valorSiEsta k ks vs  -- O(n^2)

deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
deleteM k (M ks vs) = M (borrar k kvs) -- O(n)

keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map
keys (M ks vs) = listKeys kvs -- O(n)

noKeyAssocSi :: Eq k => k -> [k] -> [k]
noKeyAssocSi k ks = if elem k ks
                       then ks
                       else k:ks

noValueAssocSi :: Eq k => [k] -> v -> [v] -> [v]
noValueAssocSi ks v vs = if (lenght ks)==(lenght vs)
                            then vs
                            else v:vs


valorSiEsta :: Eq k => k -> ks -> vs -> Maybe v
valorSiEsta k [] []           = Nothing
valorSiEsta k (k1:ks) (v1:vs) = if k==k1 
                                   then Just v1
                                   else valorSiEsta k kvs

borrar :: Eq k => k -> [(k,v)] -> [(k,v)]
borrar k []            = []
borrar k ((k1,v1):kvs) = if k==k1 
                            then borrar k kvs
                            else (k1,v1) : borrar k kvs 

listKeys :: [(k,v)] -> [k]
listKeys []          = []
listKeys ((k,v):kvs) = k : listKeys kvs