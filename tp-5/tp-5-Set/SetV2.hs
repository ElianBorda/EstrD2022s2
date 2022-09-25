module SetV2
    (Set,emptyS,addS,belongs,sizeS,removeS,unionS,setToList)
  where

data Set a = S [a] Int
-- INV.REP: 
--      * no hay

emptyS :: Set a
-- Crea un conjunto vacío.
emptyS = S [] 0 -- O(1)

addS :: Eq a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS x (S ys n) = S (x:ys) (n+1)  -- O(1)

belongs :: Eq a => a -> Set a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongs x (S ys n) = elem x ys -- O(n)

sizeS :: Eq a => Set a -> Int
-- Devuelve la cantidad de elementos distintos de un conjunto.
sizeS (S ys n) = n - (cantRepetidos ys) -- O(n)

removeS :: Eq a => a -> Set a -> Set a
-- Borra un elemento del conjunto.
removeS x (S ys n) = S (deleteIn x ys) (n-(cantRepetidosDe x ys)) -- O(n)

unionS :: Eq a => Set a -> Set a -> Set a
-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos. conjuntos.
unionS (S ys n) s = addListS ys s -- O(n)

setToList :: Eq a => Set a -> [a]
-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList (S xs n) = xs -- O(1)


-- #########
-- subtareas
-- #########

cantRepetidos :: Eq a => [a] -> Int
cantRepetidos []     = 0
cantRepetidos (x:xs) = if elem x xs 
                          then 1 + cantRepetidos xs
                          else cantRepetidos xs

cantRepetidosDe :: Eq a => a -> [a] -> Int
cantRepetidosDe x []     = 0
cantRepetidosDe x (y:ys) = if x==y
                              then 1 + cantRepetidosDe x ys
                              else cantRepetidosDe x ys

deleteIn :: Eq a => a -> [a] -> [a]
deleteIn x (y:[]) = if x==y
                       then []
                       else [y]
deleteIn x (y:ys) = if x==y
                       then deleteIn x ys
                       else y : deleteIn x ys

addListS :: Eq a => [a] -> Set a -> Set a
addListS [] s     = eliminarRepetidos s
addListS (x:xs) s = addListS xs (addS' x s) 

addS' :: Eq a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS' x (S ys n) = if elem x ys 
                    then S ys n
                    else S (x:ys) (n+1) 

eliminarRepetidos :: Eq a => Set a -> Set a
eliminarRepetidos (S xs n) = S (sacarRepetidos xs) (n-(cantRepetidos xs))

sacarRepetidos :: Eq a => [a] -> [a]
sacarRepetidos []     = []
sacarRepetidos (x:xs) = if elem x xs
                           then sacarRepetidos xs
                           else x:sacarRepetidos xs 
 