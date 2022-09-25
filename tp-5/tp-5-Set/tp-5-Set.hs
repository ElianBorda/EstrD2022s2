import SetV2

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
 deriving Show

------
pruebaSet = addS 3 (addS 3 (addS 2 (addS 1 (emptyS))))
pruebaSet2 = addS 4 (addS 5 (addS 6 (addS 1 (emptyS))))

-- Dados una lista y un conjunto, devuelve una lista con todos 
-- los elementos que pertenecen al conjunto.
losQuePertenecen :: Eq a => [a] -> Set a -> [a]
losQuePertenecen [] s     = []
losQuePertenecen (x:xs) s = if belongs x s 
                               then x:losQuePertenecen xs s
                               else losQuePertenecen xs s


-- Quita todos los elementos repetidos de la lista dada utilizando un conjunto
-- como estructura auxiliar.
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos xs = sinRepetidosEnS xs (emptyS)

sinRepetidosEnS :: Eq a => [a] -> Set a -> [a]
sinRepetidosEnS [] s     = setToList s
sinRepetidosEnS (x:xs) s = sinRepetidosEnS xs (addS x s)


-- Dado un arbol de conjuntos devuelve un conjunto con la union de todos los
-- conjuntos del arbol.
unirTodos :: Eq a => Tree (Set a) -> Set a
unirTodos EmptyT          = emptyS
unirTodos (NodeT s t1 t2) = unionS s (unionS (unirTodos t1) (unirTodos t2))


