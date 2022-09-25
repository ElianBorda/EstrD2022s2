module SetV1
    (Set,emptyS,addS,belongs,sizeS,removeS,unionS,setToList)
  where

data Set a = S [a] Int
-- INV.REP: 
--      * [a] no posee elementos repetidos


emptyS :: Set a
-- Crea un conjunto vacío.
emptyS = S [] 0 -- O(1)

addS :: Eq a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS x (S ys n) = if elem x ys 
                    then S ys n
                    else S (x:ys) (n+1)  -- O(1)

belongs :: Eq a => a -> Set a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongs x (S ys n) = elem x ys -- O(n)

sizeS :: Eq a => Set a -> Int
-- Devuelve la cantidad de elementos distintos de un conjunto.
sizeS (S ys n) = n -- O(1)

removeS :: Eq a => a -> Set a -> Set a
-- Borra un elemento del conjunto.
removeS x (S ys n) = S (deleteIn x ys) (n-1) -- O(n)

unionS :: Eq a => Set a -> Set a -> Set a
-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos. conjuntos.
unionS (S ys n) s = addListS ys s -- O(n)

setToList :: Eq a => Set a -> [a]
-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList (S xs n) = xs -- O(1)


-- #########
-- subtareas
-- #########

deleteIn :: Eq a => a -> [a] -> [a]
deleteIn x []     = error "El elemento no existe"
deleteIn x (y:ys) = if x==y
                       then ys
                       else y : deleteIn x ys

addListS :: Eq a => [a] -> Set a -> Set a
addListS [] s     = s
addListS (x:xs) s = addListS xs (addS x s) 