module MultisetV1
        (MultiSet, emptyMS,addMS,ocurrencesMS,unionMS,intersectionMS,multiSetToList)
    where
import Map

data MultiSet a = MS (Map a Int)


emptyMS :: MultiSet a
-- Propósito: denota un multiconjunto vacío.
emptyMS = MS (emptyM)

addMS :: Ord a => a -> MultiSet a -> MultiSet a
-- Propósito: dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al
-- multiconjunto.
addMS x (MS m) = MS (addOcurrence x m) 

ocurrencesMS :: Ord a => a -> MultiSet a -> Int
-- Propósito: dados un elemento y un multiconjunto indica la cantidad de apariciones de ese
-- elemento en el multiconjunto.
ocurrencesMS a (MS m) = getOcurrence a m 

unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a 
-- Propósito: dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de
-- ambos multiconjuntos.
unionMS (MS m) (MS m') = MS (unionMap m m') 

intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a 
-- Propósito: dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos
-- multiconjuntos tienen en común.
intersectionMS a b = undefined

multiSetToList :: MultiSet a -> [(a, Int)]
-- Propósito: dado un multiconjunto devuelve una lista con todos los elementos del conjunto y
-- su cantidad de ocurrencias.
multiSetToList m = undefined

addOcurrence :: Ord a => a -> Map a Int -> Map a Int
addOcurrence a m = case lookupM a m of
                        Nothing -> assocM a 1 m
                        Just n  -> assocM a (n+1) m

getOcurrence :: Ord a => a -> Map a Int -> Int
getOcurrence a m = case lookupM a m of
                        Nothing -> 0
                        Just n  -> n 

unionMap :: Ord a => Map a Int -> Map a Int -> Map a Int 
unionMap m m' = unionMapWith (keys m) m m'

unionMapWith :: Ord a => [a] -> Map a Int -> Map a Int -> Map a Int
-- Precond: Todos los elementos de [a] estan en m
unionMapWith [] m m'     = emptyM
unionMapWith (a:as) m m' = case lookupM a m' of
                                Nothing -> assocM a (fromJust (lookupM a m)) (unionMapWith as m m')
                                Just n  -> assocM a ((fromJust (lookupM a m))+n) (unionMapWith as m m')

fromJust :: Maybe a -> a
fromJust (Just a) = a 
