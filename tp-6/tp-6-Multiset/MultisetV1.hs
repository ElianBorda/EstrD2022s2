module MultisetV1
        (Multiset, emptyMS,addMS,ocurrencesMS,unionMS,intersectionMS,multiSetToList)
    where

data MultiSet a = MS (Map a Int)


emptyMS :: MultiSet a
-- Propósito: denota un multiconjunto vacío.
emptyM = MS (emptyM)

addMS :: Ord a => a -> MultiSet a -> MultiSet a
-- Propósito: dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al
-- multiconjunto.
addMS x (MS m) = MS (addOcurrence x m) 

ocurrencesMS :: Ord a => a -> MultiSet a -> Int
-- Propósito: dados un elemento y un multiconjunto indica la cantidad de apariciones de ese
-- elemento en el multiconjunto.
ocurrencesMS a (M m) = getOcurrence a m 

unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a (opcional)
-- Propósito: dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de
-- ambos multiconjuntos.

intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a (opcional)
-- Propósito: dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos
-- multiconjuntos tienen en común.

multiSetToList :: MultiSet a -> [(a, Int)]
-- Propósito: dado un multiconjunto devuelve una lista con todos los elementos del conjunto y
-- su cantidad de ocurrencias.

addOcurrence :: Ord a => a -> Map a Int -> Map a Int
addOcurrence a m = case lookupM a m of
                        Nothing -> assocM a 1 m
                        Just n  -> assocM a (n+1) m

getOcurrence :: Ord a => a -> Map a Int -> Int
getOcurrence a m = if emptyM m 
                      then 0 
                      else getOcurrence a m