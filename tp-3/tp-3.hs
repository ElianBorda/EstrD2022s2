-- 1. Tipos recursivos simples

-- 1.1. Celdas con bolitas

data Color = Azul | Rojo
    deriving Show
data Celda = Bolita Color Celda | CeldaVacia
    deriving Show

celda1 = Bolita Rojo (Bolita Azul (Bolita Rojo (Bolita Azul CeldaVacia)))

-- Dados un color y una celda, indica la cantidad de bolitas de ese color. Nota: pensar si ya
-- existe una operación sobre listas que ayude a resolver el problema.
nroBolitas :: Color -> Celda -> Int
nroBolitas _ CeldaVacia       = 0
nroBolitas c (Bolita col cel) = unoSi (esColor col c) + nroBolitas c cel

unoSi :: Bool -> Int
unoSi True = 1
unoSi False = 0

esColor :: Color -> Color -> Bool
esColor Azul Azul = True
esColor Rojo Rojo = True
esColor _ _       = False

-- Dado un color y una celda, agrega una bolita de dicho color a la celda.
poner :: Color -> Celda -> Celda
poner c cel = Bolita c cel

-- Dado un color y una celda, quita una bolita de dicho color de la celda. Nota: a diferencia de
-- Gobstones, esta función es total.
sacar :: Color -> Celda -> Celda
sacar _ CeldaVacia       = CeldaVacia
sacar c (Bolita col cel) = if esColor col c
                              then cel
                              else Bolita col (sacar c cel)

-- Dado un número n, un color c, y una celda, agrega n bolitas de color c a la celda.
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 _ cel = cel 
ponerN n c cel = ponerN (n-1) c (poner c cel) 


-- 1.2. Camino hacia el tesoro

data Objeto = Cacharro | Tesoro
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino

camino1 = Cofre [Cacharro, Cacharro] (Nada (Cofre [Cacharro] (Cofre [Cacharro,Tesoro] Fin)))
camino2 = Cofre [Cacharro, Cacharro] (Nada (Cofre [Cacharro] (Cofre [Cacharro] Fin)))
camino3 = Cofre [Cacharro, Cacharro] (Nada (Cofre [Cacharro] (Cofre [Cacharro,Tesoro] (Cofre [Tesoro,Tesoro] (Nada (Cofre [Cacharro, Cacharro] Fin))))))


-- Indica si hay un cofre con un tesoro en el camino.
hayTesoro :: Camino -> Bool
hayTesoro Fin          = False
hayTesoro (Nada c)     = hayTesoro c 
hayTesoro (Cofre os c) = tieneTesoro os || hayTesoro c

tieneTesoro :: [Objeto] -> Bool
tieneTesoro []     = False
tieneTesoro (o:os) = esTesoro o || tieneTesoro os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

-- Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
-- Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
-- Precondición: tiene que haber al menos un tesoro.
pasosHastaTesoro :: Camino -> Int
pasosHastaTesoro Fin            = error "No existe un tesoro"
pasosHastaTesoro (Nada cam)     = 1 + pasosHastaTesoro cam 
pasosHastaTesoro (Cofre os cam) = if tieneTesoro os
                                    then 0
                                    else 1 + pasosHastaTesoro cam

-- Indica si hay al menos “n” tesoros en el camino.
alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros 0 _ = True 
alMenosNTesoros n c = cantidadDeTesoros c>=n

cantidadDeTesoros :: Camino -> Int
cantidadDeTesoros Fin          = 0 
cantidadDeTesoros (Nada c)     = cantidadDeTesoros c
cantidadDeTesoros (Cofre os c) = if tieneTesoro os
                                  then 1 + cantidadDeTesoros c
                                  else cantidadDeTesoros c

-- Dado un rango de pasos, indica la cantidad de tesoros que hay en ese rango. Por ejemplo, si
-- el rango es 3 y 5, indica la cantidad de tesoros que hay entre hacer 3 pasos y hacer 5. Están
-- incluidos tanto 3 como 5 en el resultado.
cantTesorosEntre :: Int -> Int -> Camino -> Int
cantTesorosEntre 0 n c           = cantTesorosEn n c
cantTesorosEntre n m (Nada c)    = cantTesorosEntre (n-1) (m-1) c
cantTesorosEntre n m (Cofre _ c) = cantTesorosEntre (n-1) (m-1) c

cantTesorosEn :: Int -> Camino -> Int
cantTesorosEn 0 _              = 0
cantTesorosEn n Fin            = 0
cantTesorosEn n (Nada cam)     = cantTesorosEn (n-1) cam
cantTesorosEn n (Cofre os cam) = cantidadDeTesoros (Cofre os cam) + cantTesorosEn (n-1) cam

-- 2. Tipos arbóreos

-- 2.1. Árboles binarios

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
 deriving Show

node1 = NodeT 5 (NodeT 8 (NodeT 2 EmptyT EmptyT) EmptyT) (NodeT 3 EmptyT EmptyT)
node2 = NodeT 3 (NodeT 8 (NodeT 2 EmptyT EmptyT) EmptyT) (NodeT 3 EmptyT EmptyT)
--nodeToList = (NodeT 3 (NodeT 4 (NodeT "B" EmptyT EmptyT) (NodeT 5 (NodeT "A" EmptyT EmptyT) (NodeT 6 EmptyT EmptyT))) (NodeT 4 EmptyT EmptyT))
nodeToListSimple = (NodeT 5 (NodeT 4 (NodeT 6 (NodeT 10 EmptyT EmptyT) EmptyT) EmptyT) (NodeT 3 EmptyT EmptyT))

-- 1. Dado un árbol binario de enteros devuelve la suma entre sus elementos.
sumarT :: Tree Int -> Int
sumarT EmptyT          = 0
sumarT (NodeT n n1 n2) = n + sumarT n1 + sumarT n2

-- 2. Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size
-- en inglés).
sizeT :: Tree a -> Int
sizeT EmptyT          = 0 
sizeT (NodeT _ n1 n2) = 1 + sizeT n1 + sizeT n2

-- 3. Dado un árbol de enteros devuelve un árbol con el doble de cada número.
mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT          = EmptyT
mapDobleT (NodeT n n1 n2) = NodeT (n*2) (mapDobleT n1) (mapDobleT n2)

-- 4. Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el
-- arbol.
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT _ EmptyT           = False
perteneceT x (NodeT y1 n1 n2) = x==y1 || perteneceT x n1 || perteneceT x n2

-- 5. Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son
-- iguales a e.
aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT _ EmptyT          = 0
aparicionesT x (NodeT y n1 n2) = unoSi (x==y) + aparicionesT x n1 + aparicionesT x n2

-- 6. Dado un árbol devuelve los elementos que se encuentran en sus hojas.
leaves :: Tree a -> [a]
leaves EmptyT          = []
leaves (NodeT x n1 n2) = x : leaves n1 ++ leaves n2

-- 7. Dado un árbol devuelve su altura.
-- Nota: la altura de un árbol (height en inglés), también llamada profundidad, es la cantidad
-- de niveles del árbol.
-- La altura para EmptyT es 0, y para una hoja es 1.
heightT :: Tree a -> Int
heightT EmptyT          = 0
heightT (NodeT _ n1 n2) = if tieneProfundidad n1 || tieneProfundidad n2
                             then 1 + (max (heightT n1) (heightT n2))
                             else 0

tieneProfundidad :: Tree a -> Bool
tieneProfundidad EmptyT = False
tieneProfundidad _      = True

-- 8. Dado un árbol devuelve el árbol resultante de intercambiar el hijo izquierdo con el derecho,
-- en cada nodo del árbol.
mirrorT :: Tree a -> Tree a
mirrorT EmptyT          = EmptyT
mirrorT (NodeT x n1 n2) = (NodeT x n2 n1) 

-- 9. Dado un árbol devuelve una lista que representa el resultado de recorrerlo en modo in-order.
-- Nota: En el modo in-order primero se procesan los elementos del hijo izquierdo, luego la raiz
-- y luego los elementos del hijo derecho.
toList :: Tree a -> [a]
toList EmptyT          = [] 
toList (NodeT x n1 n2) = toList n2 ++ (x:[]) ++ toList n1

-- 10. Dados un número n y un árbol devuelve una lista con los nodos de nivel n. El nivel de un
-- nodo es la distancia que hay de la raíz hasta él. La distancia de la raiz a sí misma es 0, y la
-- distancia de la raiz a uno de sus hijos es 1.
-- Nota: El primer nivel de un árbol (su raíz) es 0.
levelN :: Int -> Tree a -> [a]
levelN 0 (NodeT x _ _)   = x:[] 
levelN _ EmptyT          = []
levelN n (NodeT x n1 n2) = levelN (n-1) n1 ++ levelN (n-1) n2


-- 11.Dado un árbol devuelve una lista de listas en la que cada elemento representa un nivel de
-- dicho árbol.
listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT          = []
listPerLevel (NodeT x n1 n2) = (x:[]):[] ++ concatListasDeListas (listPerLevel n1) (listPerLevel n2)

concatListasDeListas :: [[a]] -> [[a]] -> [[a]]
concatListasDeListas xss []            = xss
concatListasDeListas [] yss            = yss
concatListasDeListas (xs:xss) (ys:yss) = (xs++ys) : concatListasDeListas xss yss

-- 12. Devuelve los elementos de la rama más larga del árbol
ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT          = []
ramaMasLarga (NodeT x n1 n2) = x : if esMasLargaQue (ramaMasLarga n1) (ramaMasLarga n2)
                                        then ramaMasLarga n1
                                        else ramaMasLarga n2

esMasLargaQue :: [a] -> [a] -> Bool
esMasLargaQue xs ys = longitud xs > longitud ys

longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs  

-- 2.2. Expresiones Aritméticas

data ExpA = Valor Int | Sum ExpA ExpA | Prod ExpA ExpA | Neg ExpA
    deriving Show

exp1 = (Sum (Prod (Sum (Valor 1) (Valor 0)) (Prod (Valor 1) (Valor 0))) (Prod (Sum (Valor 1) (Valor 1)) (Neg (Valor 4))))

-- 2. Dada una expresión aritmética, la simplifica según los siguientes criterios (descritos utilizando
-- notación matemática convencional):
simplificar :: ExpA -> ExpA
simplificar (Valor m)    = Valor m
simplificar (Neg n)      = simplificarNeg (simplificar n)
simplificar (Prod n1 n2) = simplificarProd (simplificar n1) (simplificar n2)
simplificar (Sum n1 n2)  = simplificarSum (simplificar n1) (simplificar n2)

simplificarNeg :: ExpA -> ExpA
simplificarNeg (Neg ex) = ex
simplificarNeg ex       = Neg ex 

simplificarProd :: ExpA -> ExpA -> ExpA
simplificarProd (Valor 0) _  = Valor 0
simplificarProd _ (Valor 0)  = Valor 0
simplificarProd (Valor 1) ex = ex
simplificarProd ex (Valor 1) = ex
simplificarProd ex ex2       = Prod ex ex2

simplificarSum :: ExpA -> ExpA -> ExpA
simplificarSum (Valor 0) ex  = ex
simplificarSum ex (Valor 0)  = ex
simplificarSum ex1 ex2       = Sum ex1 ex2










